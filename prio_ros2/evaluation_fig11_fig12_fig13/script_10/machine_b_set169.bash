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
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_1 -p 91 -st topic169_0_0 -pt topic169_0_1 -u 0.03970227094713602 > ./result_10chains/node169_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_1 -p 164 -st topic169_1_0 -pt topic169_1_1 -u 0.015561042342641163 > ./result_10chains/node169_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_1 -p 215 -st topic169_2_0 -pt topic169_2_1 -u 0.007770403872912612 > ./result_10chains/node169_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_1 -p 344 -st topic169_3_0 -pt topic169_3_1 -u 0.01325028604799472 > ./result_10chains/node169_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_1 -p 352 -st topic169_4_0 -pt topic169_4_1 -u 0.014135496571271361 > ./result_10chains/node169_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_1 -p 366 -st topic169_5_0 -pt topic169_5_1 -u 0.007865392462726939 > ./result_10chains/node169_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_6_1 -p 721 -st topic169_6_0 -pt topic169_6_1 -u 0.013810044489822565 > ./result_10chains/node169_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_7_1 -p 748 -st topic169_7_0 -pt topic169_7_1 -u 0.0020893768906070365 > ./result_10chains/node169_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_8_1 -p 753 -st topic169_8_0 -pt topic169_8_1 -u 0.005683363294816474 > ./result_10chains/node169_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_9_1 -p 925 -st topic169_9_0 -pt topic169_9_1 -u 0.026845049267375333 > ./result_10chains/node169_9_1.txt &
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
    "./result_10chains/node169_0_1.txt 90"
    "./result_10chains/node169_1_1.txt 89"
    "./result_10chains/node169_2_1.txt 88"
    "./result_10chains/node169_3_1.txt 87"
    "./result_10chains/node169_4_1.txt 86"
    "./result_10chains/node169_5_1.txt 85"
    "./result_10chains/node169_6_1.txt 84"
    "./result_10chains/node169_7_1.txt 83"
    "./result_10chains/node169_8_1.txt 82"
    "./result_10chains/node169_9_1.txt 81"
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
