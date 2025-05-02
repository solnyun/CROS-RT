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
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_2 -p 131 -st topic315_0_1 -pt None -u 0.04694489387573075 > ./result_6chains/node315_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_2 -p 337 -st topic315_1_1 -pt None -u 0.019951473852442614 > ./result_6chains/node315_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_2 -p 523 -st topic315_2_1 -pt None -u 0.06246665742022395 > ./result_6chains/node315_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_2 -p 653 -st topic315_3_1 -pt None -u 0.032681974126037336 > ./result_6chains/node315_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_2 -p 798 -st topic315_4_1 -pt None -u 0.017775919606389485 > ./result_6chains/node315_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_2 -p 959 -st topic315_5_1 -pt None -u 0.008692097799464005 > ./result_6chains/node315_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_0_0 -p 131 -st none -pt topic315_0_0 -u 0.010077857641674126 > ./result_6chains/node315_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_1_0 -p 337 -st none -pt topic315_1_0 -u 0.010656578286764251 > ./result_6chains/node315_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_2_0 -p 523 -st none -pt topic315_2_0 -u 0.04703028409852508 > ./result_6chains/node315_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_3_0 -p 653 -st none -pt topic315_3_0 -u 0.027250573661263433 > ./result_6chains/node315_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node315_4_0 -p 798 -st none -pt topic315_4_0 -u 0.0011937268488283054 > ./result_6chains/node315_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node315_5_0 -p 959 -st none -pt topic315_5_0 -u 0.0037039295137154885 > ./result_6chains/node315_5_0.txt &
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
    "./result_6chains/node315_0_0.txt 90"
    "./result_6chains/node315_0_2.txt 90"
    "./result_6chains/node315_1_0.txt 89"
    "./result_6chains/node315_1_2.txt 89"
    "./result_6chains/node315_2_0.txt 88"
    "./result_6chains/node315_2_2.txt 88"
    "./result_6chains/node315_3_0.txt 87"
    "./result_6chains/node315_3_2.txt 87"
    "./result_6chains/node315_4_0.txt 86"
    "./result_6chains/node315_4_2.txt 86"
    "./result_6chains/node315_5_0.txt 85"
    "./result_6chains/node315_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
