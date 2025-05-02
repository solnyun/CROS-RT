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
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_2 -p 39 -st topic146_0_1 -pt None -u 0.012207917711435368 > ./result_6chains/node146_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_2 -p 221 -st topic146_1_1 -pt None -u 0.0010123672202544953 > ./result_6chains/node146_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_2 -p 287 -st topic146_2_1 -pt None -u 0.05746593247940507 > ./result_6chains/node146_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_2 -p 600 -st topic146_3_1 -pt None -u 0.07240950026643933 > ./result_6chains/node146_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_2 -p 667 -st topic146_4_1 -pt None -u 0.011878957595389705 > ./result_6chains/node146_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_2 -p 962 -st topic146_5_1 -pt None -u 0.07601912714317725 > ./result_6chains/node146_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_0 -p 39 -st none -pt topic146_0_0 -u 0.0382070890451649 > ./result_6chains/node146_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_0 -p 221 -st none -pt topic146_1_0 -u 0.017127110952395885 > ./result_6chains/node146_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_0 -p 287 -st none -pt topic146_2_0 -u 0.051673579493896615 > ./result_6chains/node146_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_0 -p 600 -st none -pt topic146_3_0 -u 0.01102851901847085 > ./result_6chains/node146_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_0 -p 667 -st none -pt topic146_4_0 -u 0.007288531899087153 > ./result_6chains/node146_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_0 -p 962 -st none -pt topic146_5_0 -u 0.02884104194114881 > ./result_6chains/node146_5_0.txt &
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
    "./result_6chains/node146_0_0.txt 90"
    "./result_6chains/node146_0_2.txt 90"
    "./result_6chains/node146_1_0.txt 89"
    "./result_6chains/node146_1_2.txt 89"
    "./result_6chains/node146_2_0.txt 88"
    "./result_6chains/node146_2_2.txt 88"
    "./result_6chains/node146_3_0.txt 87"
    "./result_6chains/node146_3_2.txt 87"
    "./result_6chains/node146_4_0.txt 86"
    "./result_6chains/node146_4_2.txt 86"
    "./result_6chains/node146_5_0.txt 85"
    "./result_6chains/node146_5_2.txt 85"
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
