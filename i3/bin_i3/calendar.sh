#!/bin/bash
# for print on terminal
##esc=$(printf '\033')
# conky output
TGL=`date +%_d`;
BLN=`date +%B`;
THN=`date +%Y`;
cal -m | sed s/"   $BLN $THN"/'\U ${color E9166C}'"$BLN $THN"'${color 2F73B6}'/ | sed s/"\(^\|[^0-9]\)$TGL"'\b'/'${alignc}\1${color E91616}'"$TGL"'${color 2F73B6}'/ | sed '/^[[:space:]]*$/d'
