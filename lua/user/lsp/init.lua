local M = {}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    tsserver = {
        disableFormatting = true,
    },
    rust_analyzer = {},
    eslint = {},
    intelephense = { disableFormatting = true },
    ansiblels = {},
    bashls = {},
    dockerls = {},
    graphql = {},
    html = {},
    jsonls = {
        disableFormatting = true,
        init_options = {
            provideFormatter = false,
        },
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    yamlls = {},

    lua_ls = {
        disableFormatting = true,
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                },
            },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
        },
    },
}

--  LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("[d", vim.diagnostic.goto_next)
    nmap("]d", vim.diagnostic.goto_prev)
    nmap("<leader>ld", function()
        vim.diagnostic.open_float { scope = "line", border = "single" }
    end)

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format { async = true }
    end, { desc = "Format current buffer with LSP" })

    nmap("<leader>f", "<Cmd>Format<CR>", "Format code")
end

local setup_null_ls = function()
    local nls = require "null-ls"
    local builtins = nls.builtins

    -- code action sources
    local code_actions = builtins.code_actions
    -- diagnostic sources
    local diagnostics = builtins.diagnostics
    -- formatting sources
    local formatting = builtins.formatting

    local utils = require "null-ls.utils"

    local u = require "null-ls.utils"
    local is_windows = vim.loop.os_uname().version:match "Windows"
    local path_separator = is_windows and "\\" or "/"

    -- try get file from project, if not exists try global
    local function get_composer_executable(exec_name)
        local exec = u.get_root()
            .. path_separator
            .. "vendor"
            .. path_separator
            .. "bin"
            .. path_separator
            .. exec_name
        local file = io.open(exec, "r")
        if file ~= nil then
            io.close(file)
            return exec
        else
            return exec_name
        end
    end

    require("null-ls").setup {
        temp_dir = "/tmp",
        debug = false,
        on_attach = M.on_attach,
        sources = {
            diagnostics.ansiblelint,
            diagnostics.markdownlint,
            -- diagnostics.stylelint,
            diagnostics.phpcs.with {
                command = get_composer_executable "phpcs",
            },
            diagnostics.phpstan.with {
                command = get_composer_executable "phpstan",
                args = {
                    "analyze",
                    "--error-format",
                    "json",
                    "--no-progress",
                    "--memory-limit=1G",
                    "$FILENAME",
                },
                timeout = 30000,
            },
            diagnostics.yamllint,
            diagnostics.zsh,

            formatting.stylua,
            formatting.prettier,
            -- formatting.stylelint.with {
            --     filetypes = { "scss", "less", "css", "sass", "typescript", "typescriptreact" },
            --     command = "./node_modules/.bin/stylelint",
            -- },
            formatting.phpcbf.with {
                command = get_composer_executable "phpcbf",
            },
            formatting.phpcsfixer.with {
                command = get_composer_executable "php-cs-fixer",
                args = {
                    "--no-interaction",
                    "--quiet",
                    "--config=./scripts/php/.php-cs-fixer.php",
                    "fix",
                    "$FILENAME",
                },
            },
            formatting.mdformat,
            formatting.shfmt,

            require "typescript.extensions.null-ls.code-actions",
        },
    }
end

M.setup_servers = function()
    local mason_lspconfig = require "mason-lspconfig"
    local cmp_lsp = require "cmp_nvim_lsp"

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_lsp.default_capabilities(capabilities)

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    local function disable_lsp_formatting(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    local function setup_server(server, config)
        local mergedConfig = vim.tbl_deep_extend("force", {
            on_attach = function(client, bufnr)
                M.on_attach(client, bufnr)

                if servers[server].disableFormatting ~= nil then
                    disable_lsp_formatting(client)
                end
            end,
            capabilities = capabilities,
        }, config)

        if server == "tsserver" then
            require("typescript").setup {
                server = mergedConfig,
            }
        elseif server == "rust_analyzer" then
            local rt = require "rust-tools"
            rt.setup {
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

                        mergedConfig.on_attach(_, bufnr)
                    end,
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            inlayHints = { locationLinks = false },
                        },
                    },
                },
            }
        else
            require("lspconfig")[server].setup(mergedConfig)
        end
    end

    -- Setup the LSP servers
    mason_lspconfig.setup_handlers {
        function(server_name)
            if servers[server_name] ~= nil then
                setup_server(server_name, servers[server_name])
            end
        end,
    }

    setup_null_ls()
end

return M
