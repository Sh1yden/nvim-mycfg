return {
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
          { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Project diagnostics" },
          { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
        end
    }
}
