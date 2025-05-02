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
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_2 -p 145 -st topic125_0_1 -pt None -u 0.05825519357002357 > ./result_6chains/node125_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_2 -p 301 -st topic125_1_1 -pt None -u 0.013588083723403865 > ./result_6chains/node125_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_2 -p 431 -st topic125_2_1 -pt None -u 0.026703468586943835 > ./result_6chains/node125_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_2 -p 445 -st topic125_3_1 -pt None -u 0.025113120626380714 > ./result_6chains/node125_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_2 -p 595 -st topic125_4_1 -pt None -u 0.030243004486745606 > ./result_6chains/node125_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_2 -p 887 -st topic125_5_1 -pt None -u 0.06427781835554836 > ./result_6chains/node125_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_0 -p 145 -st none -pt topic125_0_0 -u 0.004530107200163169 > ./result_6chains/node125_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_0 -p 301 -st none -pt topic125_1_0 -u 0.024825342771012615 > ./result_6chains/node125_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_0 -p 431 -st none -pt topic125_2_0 -u 0.0682296045957218 > ./result_6chains/node125_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_0 -p 445 -st none -pt topic125_3_0 -u 0.019130904245968805 > ./result_6chains/node125_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_0 -p 595 -st none -pt topic125_4_0 -u 0.07521185284114672 > ./result_6chains/node125_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_0 -p 887 -st none -pt topic125_5_0 -u 0.014087826006869836 > ./result_6chains/node125_5_0.txt &
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
    "./result_6chains/node125_0_0.txt 90"
    "./result_6chains/node125_0_2.txt 90"
    "./result_6chains/node125_1_0.txt 89"
    "./result_6chains/node125_1_2.txt 89"
    "./result_6chains/node125_2_0.txt 88"
    "./result_6chains/node125_2_2.txt 88"
    "./result_6chains/node125_3_0.txt 87"
    "./result_6chains/node125_3_2.txt 87"
    "./result_6chains/node125_4_0.txt 86"
    "./result_6chains/node125_4_2.txt 86"
    "./result_6chains/node125_5_0.txt 85"
    "./result_6chains/node125_5_2.txt 85"
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
