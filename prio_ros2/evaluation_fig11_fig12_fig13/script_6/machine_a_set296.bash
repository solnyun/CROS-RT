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
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_2 -p 45 -st topic296_0_1 -pt None -u 0.0067456569765659835 > ./result_6chains/node296_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_2 -p 156 -st topic296_1_1 -pt None -u 0.0487049931496395 > ./result_6chains/node296_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_2 -p 193 -st topic296_2_1 -pt None -u 0.0025348822352332934 > ./result_6chains/node296_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_2 -p 303 -st topic296_3_1 -pt None -u 0.007387144139754082 > ./result_6chains/node296_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_2 -p 331 -st topic296_4_1 -pt None -u 0.007397861679987405 > ./result_6chains/node296_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_2 -p 342 -st topic296_5_1 -pt None -u 0.03654227384123878 > ./result_6chains/node296_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_0 -p 45 -st none -pt topic296_0_0 -u 0.03818070478422109 > ./result_6chains/node296_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_0 -p 156 -st none -pt topic296_1_0 -u 0.004885117791000149 > ./result_6chains/node296_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_0 -p 193 -st none -pt topic296_2_0 -u 0.13763408944497016 > ./result_6chains/node296_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_0 -p 303 -st none -pt topic296_3_0 -u 0.002046642118412878 > ./result_6chains/node296_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_0 -p 331 -st none -pt topic296_4_0 -u 0.01165550158909788 > ./result_6chains/node296_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_0 -p 342 -st none -pt topic296_5_0 -u 0.07369137364941586 > ./result_6chains/node296_5_0.txt &
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
    "./result_6chains/node296_0_0.txt 90"
    "./result_6chains/node296_0_2.txt 90"
    "./result_6chains/node296_1_0.txt 89"
    "./result_6chains/node296_1_2.txt 89"
    "./result_6chains/node296_2_0.txt 88"
    "./result_6chains/node296_2_2.txt 88"
    "./result_6chains/node296_3_0.txt 87"
    "./result_6chains/node296_3_2.txt 87"
    "./result_6chains/node296_4_0.txt 86"
    "./result_6chains/node296_4_2.txt 86"
    "./result_6chains/node296_5_0.txt 85"
    "./result_6chains/node296_5_2.txt 85"
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
