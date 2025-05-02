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
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_2 -p 26 -st topic494_0_1 -pt None -u 0.04384978857911226 > ./result_6chains/node494_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_2 -p 418 -st topic494_1_1 -pt None -u 0.005059768682402099 > ./result_6chains/node494_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_2 -p 463 -st topic494_2_1 -pt None -u 0.00934390294477494 > ./result_6chains/node494_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_2 -p 529 -st topic494_3_1 -pt None -u 0.03653669364170842 > ./result_6chains/node494_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_2 -p 739 -st topic494_4_1 -pt None -u 0.10226086780027 > ./result_6chains/node494_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_2 -p 768 -st topic494_5_1 -pt None -u 0.0031437882024193033 > ./result_6chains/node494_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_0 -p 26 -st none -pt topic494_0_0 -u 0.011507037554008281 > ./result_6chains/node494_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_0 -p 418 -st none -pt topic494_1_0 -u 0.05766105677454003 > ./result_6chains/node494_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_0 -p 463 -st none -pt topic494_2_0 -u 0.024954847549945258 > ./result_6chains/node494_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_0 -p 529 -st none -pt topic494_3_0 -u 0.03842474756230263 > ./result_6chains/node494_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_0 -p 739 -st none -pt topic494_4_0 -u 0.0061497267129274336 > ./result_6chains/node494_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_0 -p 768 -st none -pt topic494_5_0 -u 0.0036621661678934575 > ./result_6chains/node494_5_0.txt &
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
    "./result_6chains/node494_0_0.txt 90"
    "./result_6chains/node494_0_2.txt 90"
    "./result_6chains/node494_1_0.txt 89"
    "./result_6chains/node494_1_2.txt 89"
    "./result_6chains/node494_2_0.txt 88"
    "./result_6chains/node494_2_2.txt 88"
    "./result_6chains/node494_3_0.txt 87"
    "./result_6chains/node494_3_2.txt 87"
    "./result_6chains/node494_4_0.txt 86"
    "./result_6chains/node494_4_2.txt 86"
    "./result_6chains/node494_5_0.txt 85"
    "./result_6chains/node494_5_2.txt 85"
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
