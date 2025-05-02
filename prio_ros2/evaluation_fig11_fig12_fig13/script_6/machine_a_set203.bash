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
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_2 -p 13 -st topic203_0_1 -pt None -u 0.0025459649471114565 > ./result_6chains/node203_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_2 -p 45 -st topic203_1_1 -pt None -u 0.022952494180281502 > ./result_6chains/node203_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_2 -p 162 -st topic203_2_1 -pt None -u 0.03152939251010456 > ./result_6chains/node203_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_2 -p 564 -st topic203_3_1 -pt None -u 0.0268317435918555 > ./result_6chains/node203_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_2 -p 660 -st topic203_4_1 -pt None -u 0.0017019889546732309 > ./result_6chains/node203_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_2 -p 835 -st topic203_5_1 -pt None -u 0.01874874215754149 > ./result_6chains/node203_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_0 -p 13 -st none -pt topic203_0_0 -u 0.10541418432714139 > ./result_6chains/node203_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_0 -p 45 -st none -pt topic203_1_0 -u 0.05531120806756282 > ./result_6chains/node203_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_0 -p 162 -st none -pt topic203_2_0 -u 0.029771122492546015 > ./result_6chains/node203_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_0 -p 564 -st none -pt topic203_3_0 -u 0.02196207902998991 > ./result_6chains/node203_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_0 -p 660 -st none -pt topic203_4_0 -u 0.005907521579143579 > ./result_6chains/node203_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_0 -p 835 -st none -pt topic203_5_0 -u 0.010815547563187963 > ./result_6chains/node203_5_0.txt &
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
    "./result_6chains/node203_0_0.txt 90"
    "./result_6chains/node203_0_2.txt 90"
    "./result_6chains/node203_1_0.txt 89"
    "./result_6chains/node203_1_2.txt 89"
    "./result_6chains/node203_2_0.txt 88"
    "./result_6chains/node203_2_2.txt 88"
    "./result_6chains/node203_3_0.txt 87"
    "./result_6chains/node203_3_2.txt 87"
    "./result_6chains/node203_4_0.txt 86"
    "./result_6chains/node203_4_2.txt 86"
    "./result_6chains/node203_5_0.txt 85"
    "./result_6chains/node203_5_2.txt 85"
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
