# Neovim, configured through NixVim.
{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    # Sets EDITOR and VISUAL to nvim in the session environment.
    defaultEditor = true;

    # NixVim enables these by default, but only old remote plugins need them.
    withRuby = false;
    withPython3 = false;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      signcolumn = "yes";
      splitright = true;
      splitbelow = true;
      scrolloff = 8;
    };

    # Shares the clipboard with Wayland through wl-clipboard.
    clipboard.register = "unnamedplus";

    # Installs every grammar from Nix (about 250 MiB), so no language needs
    # adding by hand and nothing compiles at runtime.
    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
    };

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
      };
    };

    # Default configs (command, file types, root markers) for language servers.
    plugins.lspconfig.enable = true;

    # Adds about 650 MiB to the closure, mostly LLVM.
    lsp.servers.nixd.enable = true;

    # File icons for Telescope; enabling it automatically is deprecated.
    plugins.web-devicons.enable = true;

    # Telescope shells out to these; extraPackages puts them on nvim's PATH
    # only, so they aren't installed system-wide.
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
