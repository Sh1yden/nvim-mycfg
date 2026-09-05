return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- lean: без telescope, без тяжелых UI. Для консоли/MVS сценария
    -- MVS остается для WinForms/тяжелого debug, nvim - легкое редактирование/тесты
    ft = { "cs", "csproj", "sln", "slnx", "props", "cshtml", "razor" },
    config = function()
      local ok, dotnet = pcall(require, "easy-dotnet")
      if not ok then
        return
      end
      dotnet.setup({
        -- Roslyn LSP автоустанавливается через dotnet tool (roslyn-language-server)
        -- не добавлять roslyn в mason-lspconfig ensure_installed - конфликт
        lsp = {
          enabled = true,
          -- razor/blazor не нужен для консоли - выключаем Node зависимость
          -- для бэка/Avalonia включи: razor = { enabled = true }
          razor = { enabled = false },
        },
        -- picker lean - fzf-lua уже есть, telescope не тянем
        picker = "fzf_lua",
        -- дефолты диагностики, без setqflist шума
        diagnostics = {
          default_severity = "error",
          setqflist = false,
        },
      })

      -- lean хоткеи через dotnet CLI, без визуальных меню
      -- сложные профилировки/deadlocks - в MVS (Parallel Stacks/Diagnostic Tools)
      -- для dotnet watch hot reload используй toggleterm: dotnet watch run
    end,
  },
}
