{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      telescope-nvim
      tokyonight-nvim
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        #python
      ]))
    ];

    extraPackages = with pkgs; [
      #pyright
    ];

    extraConfig = ''
      lua << EOF
      -- Basic options
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.signcolumn = "yes"
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.termguicolors = true

      -- Theme setup
      vim.cmd([[colorscheme tokyonight]])

      -- LSP Configuration
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
        },
      })

      local lspconfig = require("lspconfig")

      -- Global LSP keybindings
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover information" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

      -- Telescope setup and keybindings
      local telescope = require("telescope")
      telescope.setup()

      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

      -- Setup nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      -- Treesitter setup
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
      EOF
    '';
  };
}
