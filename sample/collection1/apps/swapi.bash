#!bin/bash
#
warn=''
s_type=$1
s_keyword=$2

if [ -z $1 ]; then
    s_type="people"
    warn=$(echo -e $warn',{"warning":"arg1 was missing, so default \"people\" was used."}')
fi

if [ -z $2 ]; then  
    s_keyword="r2"
    warn=$(echo -e $warn',{"warning":"arg2 was missing, so default \"R2\" was used."}')
fi

output="["$(curl https://swapi.co/api/$s_type/?search=$s_keyword)
output=$output$warn"]"

echo $output
