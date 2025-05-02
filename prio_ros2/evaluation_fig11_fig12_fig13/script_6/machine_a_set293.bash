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
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_2 -p 203 -st topic293_0_1 -pt None -u 0.010147565386196045 > ./result_6chains/node293_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_2 -p 353 -st topic293_1_1 -pt None -u 0.0026483601258839307 > ./result_6chains/node293_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_2 -p 500 -st topic293_2_1 -pt None -u 0.008659044043712372 > ./result_6chains/node293_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_2 -p 515 -st topic293_3_1 -pt None -u 0.00282232931293612 > ./result_6chains/node293_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_2 -p 700 -st topic293_4_1 -pt None -u 0.032742207356196554 > ./result_6chains/node293_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_2 -p 811 -st topic293_5_1 -pt None -u 0.011156827784808216 > ./result_6chains/node293_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_0 -p 203 -st none -pt topic293_0_0 -u 0.03142130771177892 > ./result_6chains/node293_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_0 -p 353 -st none -pt topic293_1_0 -u 0.10193774304749414 > ./result_6chains/node293_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_0 -p 500 -st none -pt topic293_2_0 -u 0.026557547612249544 > ./result_6chains/node293_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_0 -p 515 -st none -pt topic293_3_0 -u 0.020535445206668473 > ./result_6chains/node293_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_0 -p 700 -st none -pt topic293_4_0 -u 0.013358319238164593 > ./result_6chains/node293_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_0 -p 811 -st none -pt topic293_5_0 -u 0.027474659305628455 > ./result_6chains/node293_5_0.txt &
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
    "./result_6chains/node293_0_0.txt 90"
    "./result_6chains/node293_0_2.txt 90"
    "./result_6chains/node293_1_0.txt 89"
    "./result_6chains/node293_1_2.txt 89"
    "./result_6chains/node293_2_0.txt 88"
    "./result_6chains/node293_2_2.txt 88"
    "./result_6chains/node293_3_0.txt 87"
    "./result_6chains/node293_3_2.txt 87"
    "./result_6chains/node293_4_0.txt 86"
    "./result_6chains/node293_4_2.txt 86"
    "./result_6chains/node293_5_0.txt 85"
    "./result_6chains/node293_5_2.txt 85"
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
