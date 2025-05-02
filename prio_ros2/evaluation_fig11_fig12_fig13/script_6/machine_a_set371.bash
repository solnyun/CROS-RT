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
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_2 -p 201 -st topic371_0_1 -pt None -u 0.11910710380228329 > ./result_6chains/node371_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_2 -p 223 -st topic371_1_1 -pt None -u 0.009863535004600743 > ./result_6chains/node371_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_2 -p 401 -st topic371_2_1 -pt None -u 0.02365172418994843 > ./result_6chains/node371_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_2 -p 533 -st topic371_3_1 -pt None -u 0.01749913404017228 > ./result_6chains/node371_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_2 -p 581 -st topic371_4_1 -pt None -u 0.042474223089902466 > ./result_6chains/node371_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_2 -p 818 -st topic371_5_1 -pt None -u 0.014684559184968167 > ./result_6chains/node371_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_0 -p 201 -st none -pt topic371_0_0 -u 0.05019066551803186 > ./result_6chains/node371_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_0 -p 223 -st none -pt topic371_1_0 -u 0.002818608963449598 > ./result_6chains/node371_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_0 -p 401 -st none -pt topic371_2_0 -u 0.01708744840691906 > ./result_6chains/node371_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_0 -p 533 -st none -pt topic371_3_0 -u 0.01156079152622913 > ./result_6chains/node371_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_0 -p 581 -st none -pt topic371_4_0 -u 0.009452680762077559 > ./result_6chains/node371_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_0 -p 818 -st none -pt topic371_5_0 -u 0.012028839146026774 > ./result_6chains/node371_5_0.txt &
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
    "./result_6chains/node371_0_0.txt 90"
    "./result_6chains/node371_0_2.txt 90"
    "./result_6chains/node371_1_0.txt 89"
    "./result_6chains/node371_1_2.txt 89"
    "./result_6chains/node371_2_0.txt 88"
    "./result_6chains/node371_2_2.txt 88"
    "./result_6chains/node371_3_0.txt 87"
    "./result_6chains/node371_3_2.txt 87"
    "./result_6chains/node371_4_0.txt 86"
    "./result_6chains/node371_4_2.txt 86"
    "./result_6chains/node371_5_0.txt 85"
    "./result_6chains/node371_5_2.txt 85"
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
