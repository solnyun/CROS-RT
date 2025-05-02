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
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_2 -p 54 -st topic57_0_1 -pt None -u 0.005474028489017901 > ./result_8chains/node57_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_2 -p 95 -st topic57_1_1 -pt None -u 0.005389884617370111 > ./result_8chains/node57_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_2 -p 284 -st topic57_2_1 -pt None -u 0.004558152405783167 > ./result_8chains/node57_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_2 -p 323 -st topic57_3_1 -pt None -u 0.005216289968457882 > ./result_8chains/node57_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_2 -p 604 -st topic57_4_1 -pt None -u 0.002968549637046236 > ./result_8chains/node57_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_2 -p 617 -st topic57_5_1 -pt None -u 0.01864440897652303 > ./result_8chains/node57_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_6_2 -p 634 -st topic57_6_1 -pt None -u 0.009934691688619615 > ./result_8chains/node57_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_7_2 -p 727 -st topic57_7_1 -pt None -u 0.016555559959517695 > ./result_8chains/node57_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_0 -p 54 -st none -pt topic57_0_0 -u 0.0915760847697033 > ./result_8chains/node57_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_0 -p 95 -st none -pt topic57_1_0 -u 0.0716723214824172 > ./result_8chains/node57_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_0 -p 284 -st none -pt topic57_2_0 -u 0.018733907249884996 > ./result_8chains/node57_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_0 -p 323 -st none -pt topic57_3_0 -u 0.000986001721544505 > ./result_8chains/node57_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_0 -p 604 -st none -pt topic57_4_0 -u 0.0070946958986502495 > ./result_8chains/node57_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_0 -p 617 -st none -pt topic57_5_0 -u 0.02091497867324635 > ./result_8chains/node57_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_6_0 -p 634 -st none -pt topic57_6_0 -u 0.029417710476125236 > ./result_8chains/node57_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_7_0 -p 727 -st none -pt topic57_7_0 -u 0.01571722773664927 > ./result_8chains/node57_7_0.txt &
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
    "./result_8chains/node57_0_0.txt 90"
    "./result_8chains/node57_0_2.txt 90"
    "./result_8chains/node57_1_0.txt 89"
    "./result_8chains/node57_1_2.txt 89"
    "./result_8chains/node57_2_0.txt 88"
    "./result_8chains/node57_2_2.txt 88"
    "./result_8chains/node57_3_0.txt 87"
    "./result_8chains/node57_3_2.txt 87"
    "./result_8chains/node57_4_0.txt 86"
    "./result_8chains/node57_4_2.txt 86"
    "./result_8chains/node57_5_0.txt 85"
    "./result_8chains/node57_5_2.txt 85"
    "./result_8chains/node57_6_0.txt 84"
    "./result_8chains/node57_6_2.txt 84"
    "./result_8chains/node57_7_0.txt 83"
    "./result_8chains/node57_7_2.txt 83"
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
