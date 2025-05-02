#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_2 -p 57 -st topic151_0_1 -pt None -u 0.0783561532344505 > ./result_4chains/node151_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_2 -p 530 -st topic151_1_1 -pt None -u 0.0013766597612084874 > ./result_4chains/node151_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_2 -p 820 -st topic151_2_1 -pt None -u 0.049650185243071604 > ./result_4chains/node151_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_2 -p 901 -st topic151_3_1 -pt None -u 0.19430425312519567 > ./result_4chains/node151_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_0 -p 57 -st none -pt topic151_0_0 -u 0.022157653415366407 > ./result_4chains/node151_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_0 -p 530 -st none -pt topic151_1_0 -u 0.029970063385202916 > ./result_4chains/node151_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_0 -p 820 -st none -pt topic151_2_0 -u 0.013822177200457586 > ./result_4chains/node151_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_0 -p 901 -st none -pt topic151_3_0 -u 0.022066087684669167 > ./result_4chains/node151_3_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_4chains/node151_0_0.txt 90"
    "./result_4chains/node151_0_2.txt 90"
    "./result_4chains/node151_1_0.txt 89"
    "./result_4chains/node151_1_2.txt 89"
    "./result_4chains/node151_2_0.txt 88"
    "./result_4chains/node151_2_2.txt 88"
    "./result_4chains/node151_3_0.txt 87"
    "./result_4chains/node151_3_2.txt 87"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
