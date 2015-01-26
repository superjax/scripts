#!/bin/bash
# Run in your catkin_ws/src directory and it will highlight in red
# which repos you need to push/pull
# Does NOT report anything about local branches

COFF="\033[0m"
function blue { echo -e "\033[1;34m$@ ${COFF}"; }
function red  { echo -e "\033[1;31m$@ ${COFF}"; }

for dir in $(find . -maxdepth 2 -name .git -type d -prune);
do
  echo -e "\033[1;34m"
  echo $dir | awk '{split($0,array,"/")} END{print array[2]}'

  cd $dir/..

  git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
  while read local remote
  do
      
      [ -z "$remote" ] && continue
      git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
      LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
      RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
      if [ "$LEFT_AHEAD" != "0" ] || [ "$RIGHT_AHEAD" != "0" ];
      then
        red "  $local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
      else
        echo -e "  ${COFF}$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
      fi
  done

  cd ..
done
