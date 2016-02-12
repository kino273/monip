#!/bin/sh
x=$(readlink -f $0)
dir=$(dirname $x)
file=$dir/qqq
tmp=$dir/ttt

host -s myip.opendns.com resolver1.opendns.com > $file
touch $tmp
diff $file $tmp
if [ $? = 0 ]
then
  echo "no update"
  exit 0
fi
cp $file $tmp

cd $dir

rm -f $file.cpt
ccencrypt -k key $file

git add $file.cpt
git commit -m update
git push

