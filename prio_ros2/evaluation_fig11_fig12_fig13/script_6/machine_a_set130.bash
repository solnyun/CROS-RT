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
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_2 -p 38 -st topic130_0_1 -pt None -u 0.007627944319988478 > ./result_6chains/node130_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_2 -p 500 -st topic130_1_1 -pt None -u 0.029550982438594275 > ./result_6chains/node130_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_2 -p 616 -st topic130_2_1 -pt None -u 0.11309390163101965 > ./result_6chains/node130_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_2 -p 738 -st topic130_3_1 -pt None -u 0.0021217611633636 > ./result_6chains/node130_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_2 -p 781 -st topic130_4_1 -pt None -u 0.04386699177529697 > ./result_6chains/node130_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_2 -p 799 -st topic130_5_1 -pt None -u 0.016347020790831345 > ./result_6chains/node130_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_0 -p 38 -st none -pt topic130_0_0 -u 0.04232220285802657 > ./result_6chains/node130_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_0 -p 500 -st none -pt topic130_1_0 -u 0.027463537059937093 > ./result_6chains/node130_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_0 -p 616 -st none -pt topic130_2_0 -u 0.06667524082109821 > ./result_6chains/node130_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_0 -p 738 -st none -pt topic130_3_0 -u 0.02126542285650862 > ./result_6chains/node130_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_0 -p 781 -st none -pt topic130_4_0 -u 0.001043039518657557 > ./result_6chains/node130_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_0 -p 799 -st none -pt topic130_5_0 -u 0.04242455409191849 > ./result_6chains/node130_5_0.txt &
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
    "./result_6chains/node130_0_0.txt 90"
    "./result_6chains/node130_0_2.txt 90"
    "./result_6chains/node130_1_0.txt 89"
    "./result_6chains/node130_1_2.txt 89"
    "./result_6chains/node130_2_0.txt 88"
    "./result_6chains/node130_2_2.txt 88"
    "./result_6chains/node130_3_0.txt 87"
    "./result_6chains/node130_3_2.txt 87"
    "./result_6chains/node130_4_0.txt 86"
    "./result_6chains/node130_4_2.txt 86"
    "./result_6chains/node130_5_0.txt 85"
    "./result_6chains/node130_5_2.txt 85"
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
