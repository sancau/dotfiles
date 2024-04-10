local vim = vim

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local trouble = require("trouble")
        vim.keymap.set("n", "<leader>p", function() trouble.toggle() end)
    end,
}
