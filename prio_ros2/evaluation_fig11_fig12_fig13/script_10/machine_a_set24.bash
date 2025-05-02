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
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_2 -p 90 -st topic24_0_1 -pt None -u 0.0010487220630659988 > ./result_10chains/node24_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_2 -p 185 -st topic24_1_1 -pt None -u 0.004493451561256023 > ./result_10chains/node24_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_2 -p 368 -st topic24_2_1 -pt None -u 0.04629517423422885 > ./result_10chains/node24_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_2 -p 447 -st topic24_3_1 -pt None -u 0.0066529055731413544 > ./result_10chains/node24_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_2 -p 450 -st topic24_4_1 -pt None -u 0.0007007919462504453 > ./result_10chains/node24_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_2 -p 476 -st topic24_5_1 -pt None -u 0.011888994972990646 > ./result_10chains/node24_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_6_2 -p 723 -st topic24_6_1 -pt None -u 0.012499830796937283 > ./result_10chains/node24_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_7_2 -p 725 -st topic24_7_1 -pt None -u 0.05045866915291757 > ./result_10chains/node24_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_8_2 -p 869 -st topic24_8_1 -pt None -u 0.0017543913261576834 > ./result_10chains/node24_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_9_2 -p 906 -st topic24_9_1 -pt None -u 0.00030645634293611357 > ./result_10chains/node24_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_0 -p 90 -st none -pt topic24_0_0 -u 0.037706741564435764 > ./result_10chains/node24_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_0 -p 185 -st none -pt topic24_1_0 -u 0.01384796048588588 > ./result_10chains/node24_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_0 -p 368 -st none -pt topic24_2_0 -u 0.026299445540549138 > ./result_10chains/node24_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_0 -p 447 -st none -pt topic24_3_0 -u 0.02354666301992675 > ./result_10chains/node24_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_0 -p 450 -st none -pt topic24_4_0 -u 0.0028812368922570553 > ./result_10chains/node24_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_0 -p 476 -st none -pt topic24_5_0 -u 0.004631117911925886 > ./result_10chains/node24_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_6_0 -p 723 -st none -pt topic24_6_0 -u 0.023106071673499956 > ./result_10chains/node24_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_7_0 -p 725 -st none -pt topic24_7_0 -u 0.07023998010251838 > ./result_10chains/node24_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_8_0 -p 869 -st none -pt topic24_8_0 -u 0.018383734875673262 > ./result_10chains/node24_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_9_0 -p 906 -st none -pt topic24_9_0 -u 0.012771706246059111 > ./result_10chains/node24_9_0.txt &
sleep 10
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
    "./result_10chains/node24_0_0.txt 90"
    "./result_10chains/node24_0_2.txt 90"
    "./result_10chains/node24_1_0.txt 89"
    "./result_10chains/node24_1_2.txt 89"
    "./result_10chains/node24_2_0.txt 88"
    "./result_10chains/node24_2_2.txt 88"
    "./result_10chains/node24_3_0.txt 87"
    "./result_10chains/node24_3_2.txt 87"
    "./result_10chains/node24_4_0.txt 86"
    "./result_10chains/node24_4_2.txt 86"
    "./result_10chains/node24_5_0.txt 85"
    "./result_10chains/node24_5_2.txt 85"
    "./result_10chains/node24_6_0.txt 84"
    "./result_10chains/node24_6_2.txt 84"
    "./result_10chains/node24_7_0.txt 83"
    "./result_10chains/node24_7_2.txt 83"
    "./result_10chains/node24_8_0.txt 82"
    "./result_10chains/node24_8_2.txt 82"
    "./result_10chains/node24_9_0.txt 81"
    "./result_10chains/node24_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
