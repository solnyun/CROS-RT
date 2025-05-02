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
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_2 -p 59 -st topic495_0_1 -pt None -u 0.006862905865027358 > ./result_6chains/node495_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_2 -p 233 -st topic495_1_1 -pt None -u 0.002736749967759966 > ./result_6chains/node495_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_2 -p 267 -st topic495_2_1 -pt None -u 0.05731773130503015 > ./result_6chains/node495_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_2 -p 365 -st topic495_3_1 -pt None -u 0.0026602594773573185 > ./result_6chains/node495_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_2 -p 632 -st topic495_4_1 -pt None -u 0.002962789584085246 > ./result_6chains/node495_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_2 -p 969 -st topic495_5_1 -pt None -u 0.05782633000139826 > ./result_6chains/node495_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_0 -p 59 -st none -pt topic495_0_0 -u 0.03841017758315529 > ./result_6chains/node495_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_0 -p 233 -st none -pt topic495_1_0 -u 0.07513618286337298 > ./result_6chains/node495_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_0 -p 267 -st none -pt topic495_2_0 -u 0.046281081554686354 > ./result_6chains/node495_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_0 -p 365 -st none -pt topic495_3_0 -u 0.048966138769246687 > ./result_6chains/node495_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_0 -p 632 -st none -pt topic495_4_0 -u 0.043973682498440886 > ./result_6chains/node495_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_0 -p 969 -st none -pt topic495_5_0 -u 0.022927792566753757 > ./result_6chains/node495_5_0.txt &
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
    "./result_6chains/node495_0_0.txt 90"
    "./result_6chains/node495_0_2.txt 90"
    "./result_6chains/node495_1_0.txt 89"
    "./result_6chains/node495_1_2.txt 89"
    "./result_6chains/node495_2_0.txt 88"
    "./result_6chains/node495_2_2.txt 88"
    "./result_6chains/node495_3_0.txt 87"
    "./result_6chains/node495_3_2.txt 87"
    "./result_6chains/node495_4_0.txt 86"
    "./result_6chains/node495_4_2.txt 86"
    "./result_6chains/node495_5_0.txt 85"
    "./result_6chains/node495_5_2.txt 85"
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
