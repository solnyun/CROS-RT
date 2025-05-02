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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_2 -p 329 -st topic31_0_1 -pt None -u 0.014389131079308837 > ./result_8chains/node31_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_2 -p 454 -st topic31_1_1 -pt None -u 0.00488079288311305 > ./result_8chains/node31_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_2 -p 514 -st topic31_2_1 -pt None -u 0.05200718810910099 > ./result_8chains/node31_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_2 -p 517 -st topic31_3_1 -pt None -u 0.04944475855316646 > ./result_8chains/node31_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_2 -p 612 -st topic31_4_1 -pt None -u 0.005660343452854488 > ./result_8chains/node31_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_2 -p 671 -st topic31_5_1 -pt None -u 0.023246543829969796 > ./result_8chains/node31_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_2 -p 932 -st topic31_6_1 -pt None -u 0.04888590203153404 > ./result_8chains/node31_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_2 -p 948 -st topic31_7_1 -pt None -u 0.0009732358743299971 > ./result_8chains/node31_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_0 -p 329 -st none -pt topic31_0_0 -u 0.0011242001463784845 > ./result_8chains/node31_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_0 -p 454 -st none -pt topic31_1_0 -u 0.0010433823565681455 > ./result_8chains/node31_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_0 -p 514 -st none -pt topic31_2_0 -u 0.006651268341219152 > ./result_8chains/node31_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_0 -p 517 -st none -pt topic31_3_0 -u 0.03249454708733973 > ./result_8chains/node31_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_0 -p 612 -st none -pt topic31_4_0 -u 0.07355610981011915 > ./result_8chains/node31_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_0 -p 671 -st none -pt topic31_5_0 -u 0.0171148254262517 > ./result_8chains/node31_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_0 -p 932 -st none -pt topic31_6_0 -u 0.03266170614848499 > ./result_8chains/node31_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_0 -p 948 -st none -pt topic31_7_0 -u 0.0033495508253870024 > ./result_8chains/node31_7_0.txt &
sleep 10
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
    "./result_8chains/node31_0_0.txt 90"
    "./result_8chains/node31_0_2.txt 90"
    "./result_8chains/node31_1_0.txt 89"
    "./result_8chains/node31_1_2.txt 89"
    "./result_8chains/node31_2_0.txt 88"
    "./result_8chains/node31_2_2.txt 88"
    "./result_8chains/node31_3_0.txt 87"
    "./result_8chains/node31_3_2.txt 87"
    "./result_8chains/node31_4_0.txt 86"
    "./result_8chains/node31_4_2.txt 86"
    "./result_8chains/node31_5_0.txt 85"
    "./result_8chains/node31_5_2.txt 85"
    "./result_8chains/node31_6_0.txt 84"
    "./result_8chains/node31_6_2.txt 84"
    "./result_8chains/node31_7_0.txt 83"
    "./result_8chains/node31_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
