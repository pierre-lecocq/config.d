current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
fi

echo "Fetching merged branches..."
git remote prune origin
local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")

if [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
else
    echo "This will remove the following branches:"
    
    if [ -n "$local_branches" ]; then
        echo "locale branches : "
        echo "$local_branches"
    fi

    read -p "Continue? (y/n): " -n 1 choice
    echo
    
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
        # Remove local branches
        git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
        echo "No branches removed."
    fi
fi

read -p "Do you want to execute git-prune-remotes.sh ? (y/n): " -n 1 choice
echo

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    git-prune-remotes.sh
fi
