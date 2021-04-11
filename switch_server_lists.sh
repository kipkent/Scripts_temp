#!/bin/bash
echo "Type of switch arg: $1"
echo "Blue BP arg: $2"
echo "Green BP arg: $3"
echo "Blue Websock arg: $4"
echo "Green Websock arg: $5"
b='SwitchLists'
f='CreateNew'
if [ "$1" == "$b" ];
then
  mv /tmp_jen/blue.txt /tmp_jen/blue_old.txt
  mv /tmp_jen/green.txt /tmp_jen/blue.txt
  mv /tmp_jen/blue_old.txt /tmp_jen/green.txt

  mv /tmp_jen/blue_loserv.txt /tmp_jen/blue_loserv_old.txt
  mv /tmp_jen/green_loserv.txt /tmp_jen/blue_loserv.txt
  mv /tmp_jen/blue_loserv_old.txt /tmp_jen/green_loserv.txt
  exit 0
elif [ "$1" == "$f" ]
then
  cd /tmp_jen/
  echo "SOME_DETAILS:"$2>blue.txt
  sed -i 's/:/!/g' blue.txt
  sed -i 's/,/:selected;/g' blue.txt
  sed -i 's/$/:selected/' blue.txt

  echo "SOME_DETAILS:"$3>green.txt
  sed -i 's/:/!/g' green.txt
  sed -i 's/,/:selected;/g' green.txt
  sed -i 's/$/:selected/' green.txt

  echo "SOME_DETAILS:"$4>blue_loserv.txt
  sed -i 's/:/!/g' blue_loserv.txt
  sed -i 's/,/:selected;/g' blue_loserv.txt
  sed -i 's/$/:selected/' blue_loserv.txt

  echo "SOME_DETAILS:"$5>green_loserv.txt
  sed -i 's/:/!/g' green_loserv.txt
  sed -i 's/,/:selected;/g' green_loserv.txt
  sed -i 's/$/:selected/' green_loserv.txt
  exit 0
fi
else
  echo "Type of switch is not correct"
  exit 1
fi
