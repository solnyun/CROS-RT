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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_2 -p 19 -st topic413_0_1 -pt None -u 0.00556554631567352 > ./result_10chains/node413_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_2 -p 308 -st topic413_1_1 -pt None -u 0.04183853623127087 > ./result_10chains/node413_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_2 -p 365 -st topic413_2_1 -pt None -u 0.04194952189109474 > ./result_10chains/node413_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_2 -p 405 -st topic413_3_1 -pt None -u 0.0038281755534577133 > ./result_10chains/node413_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_2 -p 463 -st topic413_4_1 -pt None -u 0.008661291897006373 > ./result_10chains/node413_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_2 -p 512 -st topic413_5_1 -pt None -u 0.0008039057372121183 > ./result_10chains/node413_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_2 -p 584 -st topic413_6_1 -pt None -u 0.005291925396582797 > ./result_10chains/node413_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_2 -p 823 -st topic413_7_1 -pt None -u 0.023578431732211955 > ./result_10chains/node413_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_8_2 -p 832 -st topic413_8_1 -pt None -u 0.02441068615215823 > ./result_10chains/node413_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_9_2 -p 944 -st topic413_9_1 -pt None -u 0.00014750456663416457 > ./result_10chains/node413_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_0 -p 19 -st none -pt topic413_0_0 -u 0.014602240526084276 > ./result_10chains/node413_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_0 -p 308 -st none -pt topic413_1_0 -u 0.007062265971326642 > ./result_10chains/node413_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_0 -p 365 -st none -pt topic413_2_0 -u 0.0058201593874923074 > ./result_10chains/node413_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_0 -p 405 -st none -pt topic413_3_0 -u 0.012188913196988338 > ./result_10chains/node413_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_0 -p 463 -st none -pt topic413_4_0 -u 0.03085002640736162 > ./result_10chains/node413_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_0 -p 512 -st none -pt topic413_5_0 -u 0.02606997308223377 > ./result_10chains/node413_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_0 -p 584 -st none -pt topic413_6_0 -u 0.012698935871531397 > ./result_10chains/node413_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_0 -p 823 -st none -pt topic413_7_0 -u 0.05764226148681656 > ./result_10chains/node413_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_8_0 -p 832 -st none -pt topic413_8_0 -u 0.025724682704526908 > ./result_10chains/node413_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_9_0 -p 944 -st none -pt topic413_9_0 -u 0.011134598261725248 > ./result_10chains/node413_9_0.txt &
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
    "./result_10chains/node413_0_0.txt 90"
    "./result_10chains/node413_0_2.txt 90"
    "./result_10chains/node413_1_0.txt 89"
    "./result_10chains/node413_1_2.txt 89"
    "./result_10chains/node413_2_0.txt 88"
    "./result_10chains/node413_2_2.txt 88"
    "./result_10chains/node413_3_0.txt 87"
    "./result_10chains/node413_3_2.txt 87"
    "./result_10chains/node413_4_0.txt 86"
    "./result_10chains/node413_4_2.txt 86"
    "./result_10chains/node413_5_0.txt 85"
    "./result_10chains/node413_5_2.txt 85"
    "./result_10chains/node413_6_0.txt 84"
    "./result_10chains/node413_6_2.txt 84"
    "./result_10chains/node413_7_0.txt 83"
    "./result_10chains/node413_7_2.txt 83"
    "./result_10chains/node413_8_0.txt 82"
    "./result_10chains/node413_8_2.txt 82"
    "./result_10chains/node413_9_0.txt 81"
    "./result_10chains/node413_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
