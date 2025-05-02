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
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_2 -p 15 -st topic444_0_1 -pt None -u 0.0193517444607349 > ./result_8chains/node444_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_2 -p 30 -st topic444_1_1 -pt None -u 0.04703140009696627 > ./result_8chains/node444_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_2 -p 262 -st topic444_2_1 -pt None -u 0.03636393676527466 > ./result_8chains/node444_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_2 -p 306 -st topic444_3_1 -pt None -u 0.01654806252012933 > ./result_8chains/node444_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_2 -p 500 -st topic444_4_1 -pt None -u 0.025682784985830792 > ./result_8chains/node444_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_2 -p 771 -st topic444_5_1 -pt None -u 0.04559450355918851 > ./result_8chains/node444_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_6_2 -p 934 -st topic444_6_1 -pt None -u 0.034483179369677694 > ./result_8chains/node444_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_7_2 -p 959 -st topic444_7_1 -pt None -u 0.01247731454878604 > ./result_8chains/node444_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_0 -p 15 -st none -pt topic444_0_0 -u 0.028268052234517338 > ./result_8chains/node444_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_0 -p 30 -st none -pt topic444_1_0 -u 0.00899405464859937 > ./result_8chains/node444_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_0 -p 262 -st none -pt topic444_2_0 -u 0.0059977569558077315 > ./result_8chains/node444_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_0 -p 306 -st none -pt topic444_3_0 -u 0.03492356443996042 > ./result_8chains/node444_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_0 -p 500 -st none -pt topic444_4_0 -u 0.011289779762120616 > ./result_8chains/node444_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_0 -p 771 -st none -pt topic444_5_0 -u 0.0007900202185974203 > ./result_8chains/node444_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_6_0 -p 934 -st none -pt topic444_6_0 -u 0.036298082089710165 > ./result_8chains/node444_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_7_0 -p 959 -st none -pt topic444_7_0 -u 0.00035781762810155326 > ./result_8chains/node444_7_0.txt &
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
    "./result_8chains/node444_0_0.txt 90"
    "./result_8chains/node444_0_2.txt 90"
    "./result_8chains/node444_1_0.txt 89"
    "./result_8chains/node444_1_2.txt 89"
    "./result_8chains/node444_2_0.txt 88"
    "./result_8chains/node444_2_2.txt 88"
    "./result_8chains/node444_3_0.txt 87"
    "./result_8chains/node444_3_2.txt 87"
    "./result_8chains/node444_4_0.txt 86"
    "./result_8chains/node444_4_2.txt 86"
    "./result_8chains/node444_5_0.txt 85"
    "./result_8chains/node444_5_2.txt 85"
    "./result_8chains/node444_6_0.txt 84"
    "./result_8chains/node444_6_2.txt 84"
    "./result_8chains/node444_7_0.txt 83"
    "./result_8chains/node444_7_2.txt 83"
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
