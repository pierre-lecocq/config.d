#!/bin/sh

name_br=$(git branch | grep "*" | cut -d' ' -f2)

if [ "$name_br" = "master" ]; then
    echo "Current branch is master. Will only pull origin."

    git pull \
	&& git submodule update

    echo "Done."
    exit 0;
fi

if [ -z "$1"  ]; then
    base_br="master"
else
    base_br="$1"
fi

read -p "Rebase branch \"${name_br}\" from \"${base_br}\" ? (y/n): " ans
case "$ans" in
    "y" | "Y")
	git checkout ${base_br} \
	    && git pull \
	    && git submodule update \
	    && git checkout ${name_br} \
	    && git rebase ${base_br} ${name_br}
	;;
    *)
	echo "Nothing to do. Exiting."
	exit 1
	;;
esac

read -p "Rebase interactive against \"${base_br}\" ? (y/n): " ans
case "$ans" in
    "y" | "Y")
	git rebase -i ${base_br}
	;;
    *)
	;;
esac

echo "Done."
