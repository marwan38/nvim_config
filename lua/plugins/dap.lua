local M = {
    "mfussenegger/nvim-dap",
    ft = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "php",
    },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mxsdev/nvim-dap-vscode-js",
    },
}

M.config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local dap_vt = require "nvim-dap-virtual-text"
    local dap_vscode_js = require "dap-vscode-js"

    dap_vt.setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)

        -- Experimental Features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
    }

    -- DAP UI
    dapui.setup {
        icons = { expanded = "▾", collapsed = "▸" },
    }

    vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

    dap.set_log_level "TRACE"

    -- Automatically open UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- Enable virtual text
    vim.g.dap_virtual_text = true

    -- Keybindings
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<leader>bt", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<F5>", "<CMD>lua require('dap').continue()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<F10>", "<CMD>lua require('dap').step_over()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<F11>", "<CMD>lua require('dap').step_into()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<F12>", "<CMD>lua require('dap').step_out()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<S-F5>", "<CMD>lua require('dap').terminate()<CR>", opts)

    dap_vscode_js.setup {
        node_path = "/usr/bin/node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = { vim.fn.stdpath "data" .. "/mason/packages/vscode-js-debug/" }, -- Path to vscode-js-debug installation. TODO - does it work?
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    }

    dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath "data" .. "/mason/packages/vscode-firefox-debug/dist/adapter.bundle.js" },
    }

    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath "data" .. "/mason/packages/vscode-chrome-debug/out/src/chromeDebug.js" },
    }

    dap.configurations.typescript = {
        -- Working configs 🎉
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = "Node - Attach to process",
            type = "node2",
            request = "attach",
            processId = require("dap.utils").pick_process,
        },
        {
            name = "Firefox - Launch localhost",
            type = "firefox",
            request = "launch",
            reAttach = true,
            sourceMaps = true,
            url = "http://localhost:3000",
            -- TODO - webRoot should be set directly to workspaceFolder
            webRoot = "${workspaceFolder}/src",
            firefoxExecutable = "/usr/bin/firefox",
        },
        {
            name = "Chrome - Launch localhost",
            type = "chrome",
            request = "launch",
            runtimeExecutable = "/usr/bin/chromium",
            -- TODO - webRoot should be set directly to workspaceFolder
            webRoot = "${workspaceFolder}/src/build",
            url = "http://localhost:3000",
        },

        -- Not tested configs yet 🙀
        {
            name = "Nope - Node launch file",
            type = "node2",
            request = "launch",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "dev" },
            args = { "${file}" },
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
            name = "Nope - Debug with Chrome",
            type = "chrome",
            request = "attach",
            sourceMaps = true,
            program = "${file}",
            port = 9222,
            webRoot = "${workspaceFolder}/src",
        },
        {
            name = "Nope - Run npm run dev",
            command = "npm run dev",
            request = "launch",
            type = "node-terminal",
            cwd = "${workspaceFolder}",
        },
        {
            name = "Nope - Node - Attach with pwa-node",
            type = "pwa-node",
            skipFiles = { "<node_internals>/**" },
            request = "attach",
            processId = require("dap.utils").pick_process,
        },
    }

    dap.configurations.typescriptreact = dap.configurations.typescript
    dap.configurations.javascript = dap.configurations.typescript
    dap.configurations.javascriptreact = dap.configurations.typescript

    local HOME = vim.fn.getenv "HOME"

    -- PHP
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { HOME .. "/git/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
        {
            name = "Listen for XDebug",
            type = "php",
            request = "launch",
            port = 9003,
            pathMappings = {
                ["/srv/archipro/www/marwan/"] = "${workspaceFolder}/",
            },
            stopOnEntry = false,
            ignore = {
                "**/silverstripe-cache/**/*.php",
                "**/vendor/**/*.php",
            },
            hostname = "0.0.0.0",
        },
        {
            name = "Launch currently open script",
            type = "php",
            request = "launch",
            -- program = "${file}",
            cwd = "${workspaceRoot}",
            port = 9003,
            -- stopOnEntry = true
        },
    }
end

return M
