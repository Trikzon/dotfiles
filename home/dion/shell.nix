# Zsh with completion, suggestions, highlighting, and a git-aware prompt.
{ lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      ignoreAllDups = true;
      # Without this, each kitty window overwrites the history on exit.
      append = true;
    };

    # fzf-tab must load after compinit (order 570) and before autosuggestions
    # (700) and syntax highlighting (1200), which wrap the widgets it binds.
    initContent = lib.mkOrder 600 ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };

  # Kitty's shell integration is added to .zshrc automatically.
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  # Adds the ls, ll, la, and lt aliases for zsh.
  programs.eza = {
    enable = true;
    git = true;
  };
  programs.bat.enable = true;
}
