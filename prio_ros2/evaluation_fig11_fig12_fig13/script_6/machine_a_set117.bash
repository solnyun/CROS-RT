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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_2 -p 230 -st topic117_0_1 -pt None -u 0.0004694939691718414 > ./result_6chains/node117_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_2 -p 309 -st topic117_1_1 -pt None -u 0.04845674392836996 > ./result_6chains/node117_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_2 -p 363 -st topic117_2_1 -pt None -u 0.08295010102284295 > ./result_6chains/node117_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_2 -p 511 -st topic117_3_1 -pt None -u 0.023636674032119304 > ./result_6chains/node117_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_2 -p 575 -st topic117_4_1 -pt None -u 0.012043778440548852 > ./result_6chains/node117_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_2 -p 690 -st topic117_5_1 -pt None -u 0.01404883239880566 > ./result_6chains/node117_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_0 -p 230 -st none -pt topic117_0_0 -u 0.007837951571824653 > ./result_6chains/node117_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_0 -p 309 -st none -pt topic117_1_0 -u 0.023298467648917298 > ./result_6chains/node117_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_0 -p 363 -st none -pt topic117_2_0 -u 0.006296619077425236 > ./result_6chains/node117_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_0 -p 511 -st none -pt topic117_3_0 -u 0.03946375716523909 > ./result_6chains/node117_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_0 -p 575 -st none -pt topic117_4_0 -u 0.004320421589139201 > ./result_6chains/node117_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_0 -p 690 -st none -pt topic117_5_0 -u 0.028932702658470963 > ./result_6chains/node117_5_0.txt &
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
    "./result_6chains/node117_0_0.txt 90"
    "./result_6chains/node117_0_2.txt 90"
    "./result_6chains/node117_1_0.txt 89"
    "./result_6chains/node117_1_2.txt 89"
    "./result_6chains/node117_2_0.txt 88"
    "./result_6chains/node117_2_2.txt 88"
    "./result_6chains/node117_3_0.txt 87"
    "./result_6chains/node117_3_2.txt 87"
    "./result_6chains/node117_4_0.txt 86"
    "./result_6chains/node117_4_2.txt 86"
    "./result_6chains/node117_5_0.txt 85"
    "./result_6chains/node117_5_2.txt 85"
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
