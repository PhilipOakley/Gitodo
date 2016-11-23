#!/bin/sh
#
# SYNOPSIS
# git deadbranch [--keep|-k] <branch>
#
# Merge <branch>, as second parent, using --ours strategy,
# onto the (empty worktree) DeadBranches branch. 
#
# This is an ideal script to support a number of common workflows
# such as "haphazard", "cluttered", "tidy-up", and other BBoM[1] styles.
# 
# [1] Big Ball of Mud http://laputan.org/mud/
#
#
# git merge --onto <deadbranches> --no-checkout --strategy=ours [--keep] <deadbranch>


the root commit has no parents, and must have a file within the (git) root directory 

tree.
So we need an empty file (named EmptyDeadBranchKeeper ?) (blob from dev/nul -> mktree)
then 
git commit-tree -m"DeadBranchRoot" $emptytree > refs/heads/DeadBranches so this one has no parents 

and one tree.


emptytree=$(git hash-object -t tree --stdin < /dev/null)

next time the same commit-tree with the first parent is the refs/heads/DeadBranches, and 

the second parent the $branch, -m"Merge and delete dead branch $branch" > 

refs/heads/DeadBranches. Then delete $branch.

The linear history of the DeadBranches branch will be :-

Merge and delete dead branch $branch4
Merge and delete dead branch $branch3
Merge and delete dead branch $branch2
Merge and delete dead branch $branch1
DeadBranchRoot

so we can follow any we like.

1. Is it a valid branch name?
1a. No - tell user & give usage.
2. Is it the checked out branch?
2a. Yes- tell user & give usage.
3. Does DeadBranches branch exist yet
3a. Create branch, EmptyDeadBranchKeeper file, tree and commit.
4. determine head of DeadBranches branch, and it''s tree
4a. create merge commit.
5. delete old user branch.


http://stackoverflow.com/a/17051621/717355
exists=`git show-ref refs/heads/<branch-name>`
if [ -n "$exists" ]; then
    echo 'branch exists!'
fi

current="git rev-parse --abbrev-ref HEAD"

# -----------------------------
keep =
while test $# -gt 0
do

#-- create root commit
emptytree=$(git hash-object -t tree --stdin < /dev/null)
git commit-tree -m "DeadBranchRoot" $emptytree > $GIT_DIR/refs/heads/DeadBranches
#-- 
namedeadbranches="deadbranches"
branchsha1=
message="Merge and delete dead branch $branch"
deadbranchessha1='git show-ref -s refs/heads/$namedeadbranches'
deadbranchsha1='git show-ref -s refs/heads/$branch'
deadbranchestree='git cat-file commit $deadbranchessha1 | grep sed /tree $1/'
git commit-tree -p$deadbranchessha1 -p$deadbranchsha1 -m$message $deadbranchestree > $GIT_DIR/refs/heads/DeadBranches

exists=`git show-ref -s master` # -s sha1 only


http://stackoverflow.com/questions/7129279/sed-how-to-remove-everything-but-a-defined-pattern
$  sed  -n -E 's/(^|.*[^0-9])([0-9]{1,3})%.*/\2/p' input
123
456
The -n flag makes sed to suppress automatic output of the lines. Then, we use the -E flag which will allow us to use extended regular expressions. (In GNU sed, the flag is not -E but instead is -r).

Now comes the s/// command. The group (^|.*[^0-9]) matchs either a beginning of line (^) or a series of zero or more chars (.*) ending in a non-digit char ([^0-9]). [0-9]\{1,3\} just matches one to three digits and is bound to a group (by the ( and ) group delimiters) if the group is preceded by (^|.*[^0-9]) and followed by %. Then .* matches everything before and after this pattern. After this, we replace everything by the second group (([0-9]{1,3})) using the backreference \2. Since we passed -n to sed, nothing would be printed but we passed the p flag to the s/// command. The result is that if the replacement is executed then the resulted line is printed. Note the p is a flag of s///, not the p command, because it comes just after the last /.


So 
$  sed  -n -r 's/(^|.*[^0-9a-f])([0-9a-f]{40})%.*/\2/p' not

--------------
http://stackoverflow.com/questions/468370/a-regex-to-match-a-sha1/468410#468410

grep -o -E -e "[0-9a-f]{40}"
/\b([a-f0-9]{40})\b/

grep -o -E -e /\b([a-f0-9]{40})\b/

--------
git cat-file -p master | grep  -E -e  "^tree [a-f0-9]{40}$" | head -1 | cut -c6-45
-------
========
git rev-parse master^{tree}
========
-------
