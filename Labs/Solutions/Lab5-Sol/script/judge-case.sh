#!/bin/bash
all_pass=1
for i in {1..4}; do
  echo -n "case $i: "
  ./zuma < ./test/"case$i.in"
  if diff ./test/"case$i.out" myans.out > /tmp/zuma-diff.txt; then
    echo -e "\033[32mPASS\033[0m"
  else
    echo -e "\033[31mERROR\033[0m"
    echo "Difference at:"
    cat /tmp/zuma-diff.txt
    all_pass=0
    break
  fi
done

if [ $all_pass -eq 1 ]; then
  echo -e "\033[32mPass All Testcase Congratulation!\033[0m"
else
  echo -e "\033[31mStill Wrong, Try Again!\033[0m"
fi
