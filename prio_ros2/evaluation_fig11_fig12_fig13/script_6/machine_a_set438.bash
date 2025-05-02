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
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_2 -p 14 -st topic438_0_1 -pt None -u 0.03757972884640859 > ./result_6chains/node438_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_2 -p 155 -st topic438_1_1 -pt None -u 0.0064953814807616195 > ./result_6chains/node438_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_2 -p 250 -st topic438_2_1 -pt None -u 0.01490303711659724 > ./result_6chains/node438_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_2 -p 566 -st topic438_3_1 -pt None -u 0.017782986719529714 > ./result_6chains/node438_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_2 -p 795 -st topic438_4_1 -pt None -u 0.021847527482191556 > ./result_6chains/node438_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_2 -p 949 -st topic438_5_1 -pt None -u 0.04743960627610717 > ./result_6chains/node438_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_0 -p 14 -st none -pt topic438_0_0 -u 0.048747216721365005 > ./result_6chains/node438_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_0 -p 155 -st none -pt topic438_1_0 -u 0.006956203616699963 > ./result_6chains/node438_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_0 -p 250 -st none -pt topic438_2_0 -u 0.004967007193247164 > ./result_6chains/node438_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_0 -p 566 -st none -pt topic438_3_0 -u 0.005714970315479656 > ./result_6chains/node438_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_0 -p 795 -st none -pt topic438_4_0 -u 0.012318668544800376 > ./result_6chains/node438_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_0 -p 949 -st none -pt topic438_5_0 -u 0.04514526404579869 > ./result_6chains/node438_5_0.txt &
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
    "./result_6chains/node438_0_0.txt 90"
    "./result_6chains/node438_0_2.txt 90"
    "./result_6chains/node438_1_0.txt 89"
    "./result_6chains/node438_1_2.txt 89"
    "./result_6chains/node438_2_0.txt 88"
    "./result_6chains/node438_2_2.txt 88"
    "./result_6chains/node438_3_0.txt 87"
    "./result_6chains/node438_3_2.txt 87"
    "./result_6chains/node438_4_0.txt 86"
    "./result_6chains/node438_4_2.txt 86"
    "./result_6chains/node438_5_0.txt 85"
    "./result_6chains/node438_5_2.txt 85"
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
