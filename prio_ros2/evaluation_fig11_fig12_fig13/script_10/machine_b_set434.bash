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
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_1 -p 53 -st topic434_0_0 -pt topic434_0_1 -u 0.007022914474858644 > ./result_10chains/node434_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_1 -p 306 -st topic434_1_0 -pt topic434_1_1 -u 0.042473428724141116 > ./result_10chains/node434_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_1 -p 400 -st topic434_2_0 -pt topic434_2_1 -u 0.00038608675906653955 > ./result_10chains/node434_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_1 -p 714 -st topic434_3_0 -pt topic434_3_1 -u 0.006595330844821612 > ./result_10chains/node434_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_1 -p 730 -st topic434_4_0 -pt topic434_4_1 -u 0.07306482523834282 > ./result_10chains/node434_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_1 -p 913 -st topic434_5_0 -pt topic434_5_1 -u 0.009160533434637547 > ./result_10chains/node434_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_6_1 -p 930 -st topic434_6_0 -pt topic434_6_1 -u 0.0034460508913016774 > ./result_10chains/node434_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_7_1 -p 977 -st topic434_7_0 -pt topic434_7_1 -u 0.0022671105229390975 > ./result_10chains/node434_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_8_1 -p 989 -st topic434_8_0 -pt topic434_8_1 -u 0.010926047652491971 > ./result_10chains/node434_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_9_1 -p 991 -st topic434_9_0 -pt topic434_9_1 -u 0.03325094220877006 > ./result_10chains/node434_9_1.txt &
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
    "./result_10chains/node434_0_1.txt 90"
    "./result_10chains/node434_1_1.txt 89"
    "./result_10chains/node434_2_1.txt 88"
    "./result_10chains/node434_3_1.txt 87"
    "./result_10chains/node434_4_1.txt 86"
    "./result_10chains/node434_5_1.txt 85"
    "./result_10chains/node434_6_1.txt 84"
    "./result_10chains/node434_7_1.txt 83"
    "./result_10chains/node434_8_1.txt 82"
    "./result_10chains/node434_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
