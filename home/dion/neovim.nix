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

    lsp.servers = {
      # Adds about 650 MiB to the closure, mostly LLVM.
      nixd.enable = true;
      bashls.enable = true;
      jsonls.enable = true;
      yamlls.enable = true;
      tombi.enable = true;
      # Covers Dockerfile, Compose, and Bake files in one server.
      docker_language_server.enable = true;

      # Tied to a project's toolchain, so a version from the project's dev shell
      # takes precedence over these (packageFallback puts them last on PATH).
      basedpyright = {
        enable = true;
        packageFallback = true;
      };
      ruff = {
        enable = true;
        packageFallback = true;
      };
      vtsls = {
        enable = true;
        packageFallback = true;
      };
      ols = {
        enable = true;
        packageFallback = true;
      };
      jdtls = {
        enable = true;
        packageFallback = true;
      };
    };

    # Completion menu: <C-n>/<C-p> select, <C-y> accepts (blink's default keymap).
    plugins.blink-cmp.enable = true;

    # Starts rust-analyzer itself and adds :RustLsp commands, so rust_analyzer
    # must not also be enabled in lsp.servers.
    plugins.rustaceanvim.enable = true;
    dependencies.rust-analyzer.packageFallback = true;

    # Neovim detects Compose files as plain yaml, but docker_language_server
    # only attaches to yaml.docker-compose.
    filetype.filename = {
      "compose.yaml" = "yaml.docker-compose";
      "compose.yml" = "yaml.docker-compose";
      "docker-compose.yaml" = "yaml.docker-compose";
      "docker-compose.yml" = "yaml.docker-compose";
    };

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
