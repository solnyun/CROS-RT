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
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_2 -p 407 -st topic397_0_1 -pt None -u 0.017453810900712796 > ./result_6chains/node397_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_2 -p 419 -st topic397_1_1 -pt None -u 0.011370237212153855 > ./result_6chains/node397_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_2 -p 582 -st topic397_2_1 -pt None -u 0.00995583328374433 > ./result_6chains/node397_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_2 -p 836 -st topic397_3_1 -pt None -u 0.00745842270044178 > ./result_6chains/node397_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_2 -p 880 -st topic397_4_1 -pt None -u 0.017216281392673755 > ./result_6chains/node397_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_2 -p 932 -st topic397_5_1 -pt None -u 0.08574084146030851 > ./result_6chains/node397_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_0 -p 407 -st none -pt topic397_0_0 -u 0.02359801099387271 > ./result_6chains/node397_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_0 -p 419 -st none -pt topic397_1_0 -u 0.0484534832295484 > ./result_6chains/node397_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_0 -p 582 -st none -pt topic397_2_0 -u 0.011980614893775277 > ./result_6chains/node397_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_0 -p 836 -st none -pt topic397_3_0 -u 0.040951899852703255 > ./result_6chains/node397_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_0 -p 880 -st none -pt topic397_4_0 -u 0.004537654728693941 > ./result_6chains/node397_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_0 -p 932 -st none -pt topic397_5_0 -u 0.14384304675099951 > ./result_6chains/node397_5_0.txt &
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
    "./result_6chains/node397_0_0.txt 90"
    "./result_6chains/node397_0_2.txt 90"
    "./result_6chains/node397_1_0.txt 89"
    "./result_6chains/node397_1_2.txt 89"
    "./result_6chains/node397_2_0.txt 88"
    "./result_6chains/node397_2_2.txt 88"
    "./result_6chains/node397_3_0.txt 87"
    "./result_6chains/node397_3_2.txt 87"
    "./result_6chains/node397_4_0.txt 86"
    "./result_6chains/node397_4_2.txt 86"
    "./result_6chains/node397_5_0.txt 85"
    "./result_6chains/node397_5_2.txt 85"
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
