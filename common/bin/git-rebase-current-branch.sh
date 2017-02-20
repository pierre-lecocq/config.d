#!/bin/sh

branch=$(git branch | grep "*" | cut -d' ' -f2)

if [ "$branch" = "master" ]; then
    echo "Current branch is master. Will only pull origin."

    git pull \
	&& git submodule update

    echo "Done."
    exit 0;
fi

read -p "Rebase branch $branch ? (y/n): " ans
case "$ans" in
    "y" | "Y")
	git checkout master \
	    && git pull \
	    && git submodule update \
	    && git checkout $branch \
	    && git rebase master $branch
	;;
    *)
	echo "Nothing to do. Exiting."
	exit 1
	;;
esac

read -p "Rebase interactive against master ? (y/n): " ans
case "$ans" in
    "y" | "Y")
	git rebase -i master
	;;
    *)
	;;
esac

echo "Done."
