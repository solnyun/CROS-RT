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
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_2 -p 378 -st topic312_0_1 -pt None -u 0.005867598316764033 > ./result_6chains/node312_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_2 -p 464 -st topic312_1_1 -pt None -u 0.006468913204258353 > ./result_6chains/node312_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_2 -p 473 -st topic312_2_1 -pt None -u 0.06980208167869148 > ./result_6chains/node312_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_2 -p 604 -st topic312_3_1 -pt None -u 0.06552447050667107 > ./result_6chains/node312_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_2 -p 668 -st topic312_4_1 -pt None -u 0.009536348412732758 > ./result_6chains/node312_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_2 -p 915 -st topic312_5_1 -pt None -u 0.008661762134409952 > ./result_6chains/node312_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_0 -p 378 -st none -pt topic312_0_0 -u 0.022704448040894998 > ./result_6chains/node312_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_0 -p 464 -st none -pt topic312_1_0 -u 0.10438733261827388 > ./result_6chains/node312_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_0 -p 473 -st none -pt topic312_2_0 -u 0.055308119947544365 > ./result_6chains/node312_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_0 -p 604 -st none -pt topic312_3_0 -u 0.05171098808850777 > ./result_6chains/node312_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_0 -p 668 -st none -pt topic312_4_0 -u 0.004939539526396398 > ./result_6chains/node312_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_0 -p 915 -st none -pt topic312_5_0 -u 0.0006876727758659482 > ./result_6chains/node312_5_0.txt &
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
    "./result_6chains/node312_0_0.txt 90"
    "./result_6chains/node312_0_2.txt 90"
    "./result_6chains/node312_1_0.txt 89"
    "./result_6chains/node312_1_2.txt 89"
    "./result_6chains/node312_2_0.txt 88"
    "./result_6chains/node312_2_2.txt 88"
    "./result_6chains/node312_3_0.txt 87"
    "./result_6chains/node312_3_2.txt 87"
    "./result_6chains/node312_4_0.txt 86"
    "./result_6chains/node312_4_2.txt 86"
    "./result_6chains/node312_5_0.txt 85"
    "./result_6chains/node312_5_2.txt 85"
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
