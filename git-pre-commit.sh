#!/bin/sh
# limit file size before commiting so you don't run into issues with the big files 
# rename the file to pre-commit and place under .git/hooks/
# from https://stackoverflow.com/questions/39576257/how-to-limit-file-size-on-commit
# change the size limits with e.g. `$ git config hooks.filesizesoftlimit 100000`
# `$ git config hooks.filesizehardlimit 4000000`

hard_limit=$(git config hooks.filesizehardlimit)
soft_limit=$(git config hooks.filesizesoftlimit)
: ${hard_limit:=10000000}
: ${soft_limit:=500000}

list_new_or_modified_files()
{
    git diff --staged --name-status|sed -e '/^D/ d; /^D/! s/.\s\+//'
}

unmunge()
{
    local result="${1#\"}"
    result="${result%\"}"
    env echo -e "$result"
}

check_file_size()
{
    n=0
    while read -r munged_filename
    do
        f="$(unmunge "$munged_filename")"
        h=$(git ls-files -s "$f"|cut -d' ' -f 2)
        s=$(git cat-file -s "$h")
        if [ "$s" -gt $hard_limit ]
        then
            env echo -E 1>&2 "ERROR: hard size limit ($hard_limit) exceeded: $munged_filename ($s)"
            n=$((n+1))
        elif [ "$s" -gt $soft_limit ]
        then
            env echo -E 1>&2 "WARNING: soft size limit ($soft_limit) exceeded: $munged_filename ($s)"
        fi
    done

    [ $n -eq 0 ]
}

list_new_or_modified_files | check_file_size
