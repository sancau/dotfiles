local vim = vim

return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            local dap_python = require("dap-python")
            dap_python.setup(path)
            dap_python.test_runner = 'pytest'

            vim.keymap.set(
                { 'n' },
                '<leader>dr', function() dap_python.test_method() end, {})

            vim.keymap.set(
                { 'n' },
                '<leader>db', "<cmd> DapToggleBreakpoint <CR>", {})

            vim.keymap.set({'n'}, '<leader>dq', "<cmd> DapTerminate <CR>")
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.after.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.after.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- vim.keymap.set({'n'}, '<leader>dq', function() dapui.close() end)
            -- vim.keymap.set({'n'}, '<leader>de', function() dapui.eval() end)
        end
    }
}
