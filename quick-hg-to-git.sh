set -x
set -e

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Usage: $0 HGREPO [GITREPO]" >&2
    exit 1
fi

HGREPO=$1

if [ "$#" -eq 1 ]; then
    GITREPO=$(basename $HGREPO)
else
    GITREPO=$2
fi

if ! [ -d "$HGREPO" ] || ! [ -d "$HGREPO/.hg" ]; then
    echo "Usage: $0 HGREPO GITREPO" >&2
    echo "where HGREPO is a Mercurial repository."
fi

if [ -d "$GITREPO" ]; then
    echo "Usage: $0 HGREPO GITREPO" >&2
    echo "where GITREPO does not exist."
    exit 1
fi

echo Importing Mercurial repo $HGREPO into GIT repo $GITREPO

mkdir $GITREPO
cd $GITREPO
git clone ~/Dev/Git/fast-export .
rm -rf .git .gitignore
git init
PYTHONPATH=/usr/local/Cellar/mercurial/2.4/libexec ./hg-fast-export.sh -r $HGREPO
git clean -fx
git checkout HEAD
if [ -e .hg* ] ; then
    git rm -rf .hg*
    git commit -a -m "Removed Mercurial configuration files."
fi
cd ..
