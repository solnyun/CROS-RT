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
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_2 -p 160 -st topic194_0_1 -pt None -u 0.021033256370570186 > ./result_6chains/node194_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_2 -p 162 -st topic194_1_1 -pt None -u 0.042061950847178176 > ./result_6chains/node194_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_2 -p 254 -st topic194_2_1 -pt None -u 0.0009203781149061396 > ./result_6chains/node194_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_2 -p 572 -st topic194_3_1 -pt None -u 0.03154568303049167 > ./result_6chains/node194_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_2 -p 618 -st topic194_4_1 -pt None -u 0.0012846500453447401 > ./result_6chains/node194_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_2 -p 624 -st topic194_5_1 -pt None -u 0.012300754683515557 > ./result_6chains/node194_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_0 -p 160 -st none -pt topic194_0_0 -u 0.007916813061371708 > ./result_6chains/node194_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_0 -p 162 -st none -pt topic194_1_0 -u 0.047756983095530336 > ./result_6chains/node194_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_0 -p 254 -st none -pt topic194_2_0 -u 0.010411554425154068 > ./result_6chains/node194_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_0 -p 572 -st none -pt topic194_3_0 -u 0.017634690176619505 > ./result_6chains/node194_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_0 -p 618 -st none -pt topic194_4_0 -u 0.010155732452384963 > ./result_6chains/node194_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_0 -p 624 -st none -pt topic194_5_0 -u 0.018497361233161022 > ./result_6chains/node194_5_0.txt &
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
    "./result_6chains/node194_0_0.txt 90"
    "./result_6chains/node194_0_2.txt 90"
    "./result_6chains/node194_1_0.txt 89"
    "./result_6chains/node194_1_2.txt 89"
    "./result_6chains/node194_2_0.txt 88"
    "./result_6chains/node194_2_2.txt 88"
    "./result_6chains/node194_3_0.txt 87"
    "./result_6chains/node194_3_2.txt 87"
    "./result_6chains/node194_4_0.txt 86"
    "./result_6chains/node194_4_2.txt 86"
    "./result_6chains/node194_5_0.txt 85"
    "./result_6chains/node194_5_2.txt 85"
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
