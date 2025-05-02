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
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_2 -p 185 -st topic450_0_1 -pt None -u 0.007271865947623357 > ./result_6chains/node450_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_2 -p 409 -st topic450_1_1 -pt None -u 0.02380493723912991 > ./result_6chains/node450_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_2 -p 565 -st topic450_2_1 -pt None -u 0.03467452636600646 > ./result_6chains/node450_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_2 -p 640 -st topic450_3_1 -pt None -u 0.001634665470458721 > ./result_6chains/node450_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_2 -p 785 -st topic450_4_1 -pt None -u 0.035110177672336124 > ./result_6chains/node450_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_2 -p 947 -st topic450_5_1 -pt None -u 0.011464556072985656 > ./result_6chains/node450_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_0 -p 185 -st none -pt topic450_0_0 -u 0.04179448806238456 > ./result_6chains/node450_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_0 -p 409 -st none -pt topic450_1_0 -u 0.056212792311186255 > ./result_6chains/node450_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_0 -p 565 -st none -pt topic450_2_0 -u 0.06651739252915981 > ./result_6chains/node450_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_0 -p 640 -st none -pt topic450_3_0 -u 0.017068344934247887 > ./result_6chains/node450_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_0 -p 785 -st none -pt topic450_4_0 -u 0.01319421227430223 > ./result_6chains/node450_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_0 -p 947 -st none -pt topic450_5_0 -u 0.015917011698284557 > ./result_6chains/node450_5_0.txt &
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
    "./result_6chains/node450_0_0.txt 90"
    "./result_6chains/node450_0_2.txt 90"
    "./result_6chains/node450_1_0.txt 89"
    "./result_6chains/node450_1_2.txt 89"
    "./result_6chains/node450_2_0.txt 88"
    "./result_6chains/node450_2_2.txt 88"
    "./result_6chains/node450_3_0.txt 87"
    "./result_6chains/node450_3_2.txt 87"
    "./result_6chains/node450_4_0.txt 86"
    "./result_6chains/node450_4_2.txt 86"
    "./result_6chains/node450_5_0.txt 85"
    "./result_6chains/node450_5_2.txt 85"
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
