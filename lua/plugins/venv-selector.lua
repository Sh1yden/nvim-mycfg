return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "ibhagwan/fzf-lua",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",
    opts = {
      settings = {
        options = {
          picker = "fzf-lua",
          notify_user_on_venv_activation = true,
        },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Выбрать Python venv", ft = "python" },
    },
  },
}
