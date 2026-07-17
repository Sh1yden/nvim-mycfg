return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            local neotree = require("neo-tree")

            neotree.setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    filtered_items = {
                        visible = true,
                        show_hidden_count = true,
                    },
                    follow_current_file = { enabled = true },
                    use_libuv_file_watcher = true,
                    group_empty_dirs = true,
                },
                git_status = {
                    symbols = {
                        added     = "✚",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "",
                        staged    = "",
                        conflict  = "",
                    },
                },
                window = {
                    width = 30,
                    position = "left",
                    mappings = {
                        ["<space>"] = "none",
                    },
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                },
                default_source = "filesystem",
            })
        end,
    }
}
