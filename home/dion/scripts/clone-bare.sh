if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "usage: clone-bare <git-url> [directory]" >&2
  exit 1
fi

url=$1
name=${2:-}
if [ -z "$name" ]; then
  # Works for both https://host/owner/repo.git and git@host:owner/repo.git
  name=${url##*[/:]}
  name=${name%.git}
fi

mkdir "$name"
cd "$name"

git clone --bare "$url" .bare
echo "gitdir: ./.bare" >.git

# A bare clone doesn't set up remote-tracking branches, so fix the fetch refspec
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin

# A bare clone's HEAD points at the remote's default branch
branch=$(git symbolic-ref --short HEAD)
git worktree add "$branch" "$branch"
git branch --set-upstream-to="origin/$branch" "$branch"
