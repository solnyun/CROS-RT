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
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_2 -p 34 -st topic459_0_1 -pt None -u 0.024099380927563585 > ./result_6chains/node459_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_2 -p 54 -st topic459_1_1 -pt None -u 0.05715510465723578 > ./result_6chains/node459_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_2 -p 245 -st topic459_2_1 -pt None -u 0.08229146300266243 > ./result_6chains/node459_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_2 -p 438 -st topic459_3_1 -pt None -u 0.032685804041178684 > ./result_6chains/node459_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_2 -p 561 -st topic459_4_1 -pt None -u 0.006967954943390198 > ./result_6chains/node459_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_2 -p 822 -st topic459_5_1 -pt None -u 0.04929738092707158 > ./result_6chains/node459_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_0 -p 34 -st none -pt topic459_0_0 -u 0.014839098624392366 > ./result_6chains/node459_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_0 -p 54 -st none -pt topic459_1_0 -u 0.03330512044358508 > ./result_6chains/node459_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_0 -p 245 -st none -pt topic459_2_0 -u 0.006716994530911846 > ./result_6chains/node459_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_0 -p 438 -st none -pt topic459_3_0 -u 0.0033325447615077664 > ./result_6chains/node459_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_0 -p 561 -st none -pt topic459_4_0 -u 0.03585768081983555 > ./result_6chains/node459_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_0 -p 822 -st none -pt topic459_5_0 -u 0.028644133129159477 > ./result_6chains/node459_5_0.txt &
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
    "./result_6chains/node459_0_0.txt 90"
    "./result_6chains/node459_0_2.txt 90"
    "./result_6chains/node459_1_0.txt 89"
    "./result_6chains/node459_1_2.txt 89"
    "./result_6chains/node459_2_0.txt 88"
    "./result_6chains/node459_2_2.txt 88"
    "./result_6chains/node459_3_0.txt 87"
    "./result_6chains/node459_3_2.txt 87"
    "./result_6chains/node459_4_0.txt 86"
    "./result_6chains/node459_4_2.txt 86"
    "./result_6chains/node459_5_0.txt 85"
    "./result_6chains/node459_5_2.txt 85"
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
