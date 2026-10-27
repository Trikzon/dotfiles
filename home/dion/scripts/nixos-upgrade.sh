cd ~/.dotfiles

# Otherwise the lock file bump would be mixed in with unrelated edits, and
# discarding it on "no" would be less safe.
if [ -n "$(git status --porcelain)" ]; then
  echo "nixos-upgrade: ~/.dotfiles has uncommitted changes, commit or stash them first" >&2
  exit 1
fi

trap 'rm -f result' EXIT

nix flake update
nixos-rebuild build --flake ".#$(hostname)"
nix store diff-closures /run/current-system ./result

read -r -p "Apply? [y/N] " answer
if [ "$answer" = y ] || [ "$answer" = Y ]; then
  nixos-rebuild switch --flake . --sudo
  echo "Applied. Commit the new lock file: git commit -am 'chore: update flake inputs'"
else
  git checkout flake.lock
  echo "Discarded the flake.lock update."
fi
