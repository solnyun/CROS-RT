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
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_2 -p 133 -st topic447_0_1 -pt None -u 0.0277726539375458 > ./result_8chains/node447_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_2 -p 186 -st topic447_1_1 -pt None -u 0.016306808971746245 > ./result_8chains/node447_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_2 -p 437 -st topic447_2_1 -pt None -u 0.019420763542234376 > ./result_8chains/node447_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_2 -p 493 -st topic447_3_1 -pt None -u 0.03132226453243192 > ./result_8chains/node447_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_2 -p 503 -st topic447_4_1 -pt None -u 0.00503713251886978 > ./result_8chains/node447_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_2 -p 649 -st topic447_5_1 -pt None -u 0.00866609848657443 > ./result_8chains/node447_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_6_2 -p 847 -st topic447_6_1 -pt None -u 0.0025821577727921374 > ./result_8chains/node447_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_7_2 -p 955 -st topic447_7_1 -pt None -u 0.030073523197852153 > ./result_8chains/node447_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_0 -p 133 -st none -pt topic447_0_0 -u 0.0013608132671513729 > ./result_8chains/node447_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_0 -p 186 -st none -pt topic447_1_0 -u 0.002459313455759282 > ./result_8chains/node447_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_0 -p 437 -st none -pt topic447_2_0 -u 0.012492356049768671 > ./result_8chains/node447_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_0 -p 493 -st none -pt topic447_3_0 -u 0.02925078266300013 > ./result_8chains/node447_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_0 -p 503 -st none -pt topic447_4_0 -u 0.04321517470840075 > ./result_8chains/node447_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_0 -p 649 -st none -pt topic447_5_0 -u 0.022259632388910683 > ./result_8chains/node447_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_6_0 -p 847 -st none -pt topic447_6_0 -u 0.025972660272618242 > ./result_8chains/node447_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_7_0 -p 955 -st none -pt topic447_7_0 -u 0.02542243148277052 > ./result_8chains/node447_7_0.txt &
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
    "./result_8chains/node447_0_0.txt 90"
    "./result_8chains/node447_0_2.txt 90"
    "./result_8chains/node447_1_0.txt 89"
    "./result_8chains/node447_1_2.txt 89"
    "./result_8chains/node447_2_0.txt 88"
    "./result_8chains/node447_2_2.txt 88"
    "./result_8chains/node447_3_0.txt 87"
    "./result_8chains/node447_3_2.txt 87"
    "./result_8chains/node447_4_0.txt 86"
    "./result_8chains/node447_4_2.txt 86"
    "./result_8chains/node447_5_0.txt 85"
    "./result_8chains/node447_5_2.txt 85"
    "./result_8chains/node447_6_0.txt 84"
    "./result_8chains/node447_6_2.txt 84"
    "./result_8chains/node447_7_0.txt 83"
    "./result_8chains/node447_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
