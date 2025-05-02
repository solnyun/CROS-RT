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
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_2 -p 81 -st topic15_0_1 -pt None -u 0.016654747971361572 > ./result_6chains/node15_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_2 -p 194 -st topic15_1_1 -pt None -u 0.0017606193490666278 > ./result_6chains/node15_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_2 -p 245 -st topic15_2_1 -pt None -u 0.07418860064619126 > ./result_6chains/node15_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_2 -p 346 -st topic15_3_1 -pt None -u 0.022043257795645213 > ./result_6chains/node15_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_2 -p 388 -st topic15_4_1 -pt None -u 0.02407837439424372 > ./result_6chains/node15_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_2 -p 509 -st topic15_5_1 -pt None -u 0.009486049966856886 > ./result_6chains/node15_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_0 -p 81 -st none -pt topic15_0_0 -u 0.06438762014580646 > ./result_6chains/node15_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_0 -p 194 -st none -pt topic15_1_0 -u 0.035323281712591637 > ./result_6chains/node15_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_0 -p 245 -st none -pt topic15_2_0 -u 0.05852925367712769 > ./result_6chains/node15_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_0 -p 346 -st none -pt topic15_3_0 -u 0.05978565573901293 > ./result_6chains/node15_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_0 -p 388 -st none -pt topic15_4_0 -u 0.0562428341180369 > ./result_6chains/node15_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_0 -p 509 -st none -pt topic15_5_0 -u 0.0036788191926216494 > ./result_6chains/node15_5_0.txt &
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
    "./result_6chains/node15_0_0.txt 90"
    "./result_6chains/node15_0_2.txt 90"
    "./result_6chains/node15_1_0.txt 89"
    "./result_6chains/node15_1_2.txt 89"
    "./result_6chains/node15_2_0.txt 88"
    "./result_6chains/node15_2_2.txt 88"
    "./result_6chains/node15_3_0.txt 87"
    "./result_6chains/node15_3_2.txt 87"
    "./result_6chains/node15_4_0.txt 86"
    "./result_6chains/node15_4_2.txt 86"
    "./result_6chains/node15_5_0.txt 85"
    "./result_6chains/node15_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
