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
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_2 -p 52 -st topic328_0_1 -pt None -u 0.01914542520474022 > ./result_10chains/node328_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_2 -p 56 -st topic328_1_1 -pt None -u 0.0019750731692419476 > ./result_10chains/node328_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_2 -p 94 -st topic328_2_1 -pt None -u 0.004729245729029774 > ./result_10chains/node328_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_2 -p 126 -st topic328_3_1 -pt None -u 0.050329447330644594 > ./result_10chains/node328_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_2 -p 359 -st topic328_4_1 -pt None -u 0.0031283643618730816 > ./result_10chains/node328_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_2 -p 591 -st topic328_5_1 -pt None -u 0.026033225722848607 > ./result_10chains/node328_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_2 -p 596 -st topic328_6_1 -pt None -u 0.007940618437350971 > ./result_10chains/node328_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_2 -p 700 -st topic328_7_1 -pt None -u 0.006494124665764087 > ./result_10chains/node328_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_8_2 -p 803 -st topic328_8_1 -pt None -u 0.0343146100648339 > ./result_10chains/node328_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_9_2 -p 830 -st topic328_9_1 -pt None -u 0.016496508117261815 > ./result_10chains/node328_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_0 -p 52 -st none -pt topic328_0_0 -u 0.013184187899313471 > ./result_10chains/node328_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_0 -p 56 -st none -pt topic328_1_0 -u 0.01729962471305041 > ./result_10chains/node328_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_0 -p 94 -st none -pt topic328_2_0 -u 0.005513446799155053 > ./result_10chains/node328_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_0 -p 126 -st none -pt topic328_3_0 -u 0.0645021019276254 > ./result_10chains/node328_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_0 -p 359 -st none -pt topic328_4_0 -u 0.01485686996916566 > ./result_10chains/node328_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_0 -p 591 -st none -pt topic328_5_0 -u 0.01563988470325353 > ./result_10chains/node328_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_0 -p 596 -st none -pt topic328_6_0 -u 0.018483056549154275 > ./result_10chains/node328_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_0 -p 700 -st none -pt topic328_7_0 -u 0.012077329538464465 > ./result_10chains/node328_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_8_0 -p 803 -st none -pt topic328_8_0 -u 0.015805696427994675 > ./result_10chains/node328_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_9_0 -p 830 -st none -pt topic328_9_0 -u 0.00961899370841298 > ./result_10chains/node328_9_0.txt &
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
    "./result_10chains/node328_0_0.txt 90"
    "./result_10chains/node328_0_2.txt 90"
    "./result_10chains/node328_1_0.txt 89"
    "./result_10chains/node328_1_2.txt 89"
    "./result_10chains/node328_2_0.txt 88"
    "./result_10chains/node328_2_2.txt 88"
    "./result_10chains/node328_3_0.txt 87"
    "./result_10chains/node328_3_2.txt 87"
    "./result_10chains/node328_4_0.txt 86"
    "./result_10chains/node328_4_2.txt 86"
    "./result_10chains/node328_5_0.txt 85"
    "./result_10chains/node328_5_2.txt 85"
    "./result_10chains/node328_6_0.txt 84"
    "./result_10chains/node328_6_2.txt 84"
    "./result_10chains/node328_7_0.txt 83"
    "./result_10chains/node328_7_2.txt 83"
    "./result_10chains/node328_8_0.txt 82"
    "./result_10chains/node328_8_2.txt 82"
    "./result_10chains/node328_9_0.txt 81"
    "./result_10chains/node328_9_2.txt 81"
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
