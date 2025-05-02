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
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_2 -p 66 -st topic153_0_1 -pt None -u 0.00693907296973334 > ./result_6chains/node153_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_2 -p 84 -st topic153_1_1 -pt None -u 0.018678649435508454 > ./result_6chains/node153_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_2 -p 317 -st topic153_2_1 -pt None -u 0.027837203268826827 > ./result_6chains/node153_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_2 -p 550 -st topic153_3_1 -pt None -u 0.032924487218843695 > ./result_6chains/node153_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_2 -p 616 -st topic153_4_1 -pt None -u 0.0187267653429094 > ./result_6chains/node153_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_2 -p 744 -st topic153_5_1 -pt None -u 0.01482733394789601 > ./result_6chains/node153_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_0 -p 66 -st none -pt topic153_0_0 -u 0.0192343433272128 > ./result_6chains/node153_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_0 -p 84 -st none -pt topic153_1_0 -u 0.030379847625283285 > ./result_6chains/node153_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_0 -p 317 -st none -pt topic153_2_0 -u 0.04917525742360673 > ./result_6chains/node153_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_0 -p 550 -st none -pt topic153_3_0 -u 0.0267947925631144 > ./result_6chains/node153_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_0 -p 616 -st none -pt topic153_4_0 -u 0.04995365103093699 > ./result_6chains/node153_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_0 -p 744 -st none -pt topic153_5_0 -u 0.03187107948314002 > ./result_6chains/node153_5_0.txt &
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
    "./result_6chains/node153_0_0.txt 90"
    "./result_6chains/node153_0_2.txt 90"
    "./result_6chains/node153_1_0.txt 89"
    "./result_6chains/node153_1_2.txt 89"
    "./result_6chains/node153_2_0.txt 88"
    "./result_6chains/node153_2_2.txt 88"
    "./result_6chains/node153_3_0.txt 87"
    "./result_6chains/node153_3_2.txt 87"
    "./result_6chains/node153_4_0.txt 86"
    "./result_6chains/node153_4_2.txt 86"
    "./result_6chains/node153_5_0.txt 85"
    "./result_6chains/node153_5_2.txt 85"
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
