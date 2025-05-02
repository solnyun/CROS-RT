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
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_2 -p 79 -st topic474_0_1 -pt None -u 0.006176670328115863 > ./result_8chains/node474_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_2 -p 409 -st topic474_1_1 -pt None -u 0.02620466818173134 > ./result_8chains/node474_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_2 -p 598 -st topic474_2_1 -pt None -u 0.04705864297366358 > ./result_8chains/node474_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_2 -p 772 -st topic474_3_1 -pt None -u 0.011075380277188518 > ./result_8chains/node474_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_2 -p 866 -st topic474_4_1 -pt None -u 0.009528077299331944 > ./result_8chains/node474_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_2 -p 896 -st topic474_5_1 -pt None -u 0.03408471894498502 > ./result_8chains/node474_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_6_2 -p 930 -st topic474_6_1 -pt None -u 0.0398116675652152 > ./result_8chains/node474_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_7_2 -p 996 -st topic474_7_1 -pt None -u 0.015655877116301405 > ./result_8chains/node474_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_0 -p 79 -st none -pt topic474_0_0 -u 0.010181966737511483 > ./result_8chains/node474_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_0 -p 409 -st none -pt topic474_1_0 -u 0.01904296428584873 > ./result_8chains/node474_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_0 -p 598 -st none -pt topic474_2_0 -u 0.052187900760645 > ./result_8chains/node474_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_0 -p 772 -st none -pt topic474_3_0 -u 0.043286416639762015 > ./result_8chains/node474_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_0 -p 866 -st none -pt topic474_4_0 -u 0.02758401596661636 > ./result_8chains/node474_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_0 -p 896 -st none -pt topic474_5_0 -u 0.019991254691190924 > ./result_8chains/node474_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_6_0 -p 930 -st none -pt topic474_6_0 -u 0.010646936905514742 > ./result_8chains/node474_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_7_0 -p 996 -st none -pt topic474_7_0 -u 0.006120272280713511 > ./result_8chains/node474_7_0.txt &
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
    "./result_8chains/node474_0_0.txt 90"
    "./result_8chains/node474_0_2.txt 90"
    "./result_8chains/node474_1_0.txt 89"
    "./result_8chains/node474_1_2.txt 89"
    "./result_8chains/node474_2_0.txt 88"
    "./result_8chains/node474_2_2.txt 88"
    "./result_8chains/node474_3_0.txt 87"
    "./result_8chains/node474_3_2.txt 87"
    "./result_8chains/node474_4_0.txt 86"
    "./result_8chains/node474_4_2.txt 86"
    "./result_8chains/node474_5_0.txt 85"
    "./result_8chains/node474_5_2.txt 85"
    "./result_8chains/node474_6_0.txt 84"
    "./result_8chains/node474_6_2.txt 84"
    "./result_8chains/node474_7_0.txt 83"
    "./result_8chains/node474_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
