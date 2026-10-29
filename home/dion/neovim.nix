# Neovim, configured through NixVim.
{ ... }: {
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
  };
}
