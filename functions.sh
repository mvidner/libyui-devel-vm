git_get() {
    local URL=$1
    local NAME=${URL##*/}

    if test -d $NAME; then
        (cd $NAME; git pull)
    else
        git clone $URL
    fi
}

# $1 repo name
build_it() {
    local WHAT=$1
    case $WHAT in
        */*) URL=$WHAT ;;
        *)   URL=https://github.com/libyui/$WHAT ;;
    esac
    NAME=${URL##*/}

    git_get $URL
    (
        cd $NAME
        local REMOTE=origin
        git config --add remote.$REMOTE.fetch \
            "+refs/pull/*/head:refs/remotes/$REMOTE/pr/*"
        if test -f ./bootstrap.sh; then
           mkdir build
           cd build
           cmake .. -DCMAKE_BUILD_TYPE=RELWITHDEBINFO
        else
            make -f Makefile.cvs
        fi
        make && sudo make install # make test
    )
}

test_it() {
    (
        cd $1
        cd build
        make test # ?! no tests enabled?
    )
}
