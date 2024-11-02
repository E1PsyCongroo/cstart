#!/bin/bash
all_pass=1
for i in {1..5}; do
  echo -n "第 $i 次测试："
  ./script/datamaker
  ./zuma < random_case.in
  if diff random_case.out myans.out > /tmp/zuma-diff.txt; then
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
  echo "Pass All Testcase Congratulation!"
else
  echo "Still Wrong, Try Again!"
fi
