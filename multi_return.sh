#!/bin/bash
trap "exit 1" SIGQUIT
export ME=$$
echo $ME
calc()
{
  A=$1
  B=$2
  total=$(( A + B ))
  diff=$(( A - B ))
  echo "Oh my bad" >&2
  kill -s SIGQUIT $ME
  echo $$ >&2
  kill -9 $ME
  echo "$total $diff"
}
read TOT DIF < <(calc $1 $2)
echo $TOT
echo $DIF
