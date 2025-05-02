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
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_2 -p 174 -st topic141_0_1 -pt None -u 0.019685238190316534 > ./result_6chains/node141_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_2 -p 269 -st topic141_1_1 -pt None -u 0.014289772964449915 > ./result_6chains/node141_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_2 -p 797 -st topic141_2_1 -pt None -u 0.01009925321663288 > ./result_6chains/node141_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_2 -p 813 -st topic141_3_1 -pt None -u 0.0019907892716476 > ./result_6chains/node141_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_2 -p 917 -st topic141_4_1 -pt None -u 0.018102632750225195 > ./result_6chains/node141_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_2 -p 954 -st topic141_5_1 -pt None -u 0.06491328050343585 > ./result_6chains/node141_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_0 -p 174 -st none -pt topic141_0_0 -u 0.04874828674652182 > ./result_6chains/node141_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_0 -p 269 -st none -pt topic141_1_0 -u 0.0050811282130029944 > ./result_6chains/node141_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_0 -p 797 -st none -pt topic141_2_0 -u 0.06866662414340871 > ./result_6chains/node141_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_0 -p 813 -st none -pt topic141_3_0 -u 0.003140420702787805 > ./result_6chains/node141_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_0 -p 917 -st none -pt topic141_4_0 -u 0.008090051838914591 > ./result_6chains/node141_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_0 -p 954 -st none -pt topic141_5_0 -u 0.005871700108886879 > ./result_6chains/node141_5_0.txt &
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
    "./result_6chains/node141_0_0.txt 90"
    "./result_6chains/node141_0_2.txt 90"
    "./result_6chains/node141_1_0.txt 89"
    "./result_6chains/node141_1_2.txt 89"
    "./result_6chains/node141_2_0.txt 88"
    "./result_6chains/node141_2_2.txt 88"
    "./result_6chains/node141_3_0.txt 87"
    "./result_6chains/node141_3_2.txt 87"
    "./result_6chains/node141_4_0.txt 86"
    "./result_6chains/node141_4_2.txt 86"
    "./result_6chains/node141_5_0.txt 85"
    "./result_6chains/node141_5_2.txt 85"
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
