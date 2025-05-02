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
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_2 -p 44 -st topic228_0_1 -pt None -u 0.0035655266551847253 > ./result_6chains/node228_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_2 -p 265 -st topic228_1_1 -pt None -u 0.10047566084358611 > ./result_6chains/node228_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_2 -p 269 -st topic228_2_1 -pt None -u 0.013472514371601713 > ./result_6chains/node228_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_2 -p 345 -st topic228_3_1 -pt None -u 0.02972491890038717 > ./result_6chains/node228_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_2 -p 388 -st topic228_4_1 -pt None -u 0.0328091733889008 > ./result_6chains/node228_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_2 -p 787 -st topic228_5_1 -pt None -u 0.04496879187370373 > ./result_6chains/node228_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_0 -p 44 -st none -pt topic228_0_0 -u 0.019226137665689647 > ./result_6chains/node228_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_0 -p 265 -st none -pt topic228_1_0 -u 0.02443180041875942 > ./result_6chains/node228_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_0 -p 269 -st none -pt topic228_2_0 -u 0.024402747863470242 > ./result_6chains/node228_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_0 -p 345 -st none -pt topic228_3_0 -u 0.02008991973791263 > ./result_6chains/node228_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_0 -p 388 -st none -pt topic228_4_0 -u 0.0034416501187889414 > ./result_6chains/node228_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_0 -p 787 -st none -pt topic228_5_0 -u 0.000772178081660066 > ./result_6chains/node228_5_0.txt &
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
    "./result_6chains/node228_0_0.txt 90"
    "./result_6chains/node228_0_2.txt 90"
    "./result_6chains/node228_1_0.txt 89"
    "./result_6chains/node228_1_2.txt 89"
    "./result_6chains/node228_2_0.txt 88"
    "./result_6chains/node228_2_2.txt 88"
    "./result_6chains/node228_3_0.txt 87"
    "./result_6chains/node228_3_2.txt 87"
    "./result_6chains/node228_4_0.txt 86"
    "./result_6chains/node228_4_2.txt 86"
    "./result_6chains/node228_5_0.txt 85"
    "./result_6chains/node228_5_2.txt 85"
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
