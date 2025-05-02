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
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_2 -p 157 -st topic79_0_1 -pt None -u 0.00882746539644469 > ./result_6chains/node79_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_2 -p 492 -st topic79_1_1 -pt None -u 0.01360413630818158 > ./result_6chains/node79_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_2 -p 532 -st topic79_2_1 -pt None -u 0.01851900153860242 > ./result_6chains/node79_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_2 -p 675 -st topic79_3_1 -pt None -u 0.01672457815681294 > ./result_6chains/node79_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_2 -p 724 -st topic79_4_1 -pt None -u 0.003945128866638087 > ./result_6chains/node79_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_2 -p 757 -st topic79_5_1 -pt None -u 0.0043689073838219196 > ./result_6chains/node79_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_0 -p 157 -st none -pt topic79_0_0 -u 0.0021228554639706188 > ./result_6chains/node79_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_0 -p 492 -st none -pt topic79_1_0 -u 0.07423140615484514 > ./result_6chains/node79_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_0 -p 532 -st none -pt topic79_2_0 -u 0.12181407368207972 > ./result_6chains/node79_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_0 -p 675 -st none -pt topic79_3_0 -u 0.0023702657605021715 > ./result_6chains/node79_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_0 -p 724 -st none -pt topic79_4_0 -u 0.03246502967771557 > ./result_6chains/node79_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_0 -p 757 -st none -pt topic79_5_0 -u 0.006521173081114731 > ./result_6chains/node79_5_0.txt &
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
    "./result_6chains/node79_0_0.txt 90"
    "./result_6chains/node79_0_2.txt 90"
    "./result_6chains/node79_1_0.txt 89"
    "./result_6chains/node79_1_2.txt 89"
    "./result_6chains/node79_2_0.txt 88"
    "./result_6chains/node79_2_2.txt 88"
    "./result_6chains/node79_3_0.txt 87"
    "./result_6chains/node79_3_2.txt 87"
    "./result_6chains/node79_4_0.txt 86"
    "./result_6chains/node79_4_2.txt 86"
    "./result_6chains/node79_5_0.txt 85"
    "./result_6chains/node79_5_2.txt 85"
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
