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
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_2 -p 95 -st topic456_0_1 -pt None -u 0.00042660190342175275 > ./result_8chains/node456_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_2 -p 238 -st topic456_1_1 -pt None -u 0.0011387824402664393 > ./result_8chains/node456_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_2 -p 287 -st topic456_2_1 -pt None -u 0.026492067389952634 > ./result_8chains/node456_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_2 -p 299 -st topic456_3_1 -pt None -u 0.035817927294642005 > ./result_8chains/node456_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_2 -p 470 -st topic456_4_1 -pt None -u 0.005305958652206955 > ./result_8chains/node456_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_2 -p 571 -st topic456_5_1 -pt None -u 0.0049373672457628665 > ./result_8chains/node456_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_6_2 -p 676 -st topic456_6_1 -pt None -u 0.032363949018648974 > ./result_8chains/node456_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_7_2 -p 790 -st topic456_7_1 -pt None -u 0.02968344013841876 > ./result_8chains/node456_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_0 -p 95 -st none -pt topic456_0_0 -u 0.015871474447059608 > ./result_8chains/node456_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_0 -p 238 -st none -pt topic456_1_0 -u 0.08269840886388952 > ./result_8chains/node456_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_0 -p 287 -st none -pt topic456_2_0 -u 0.0034763580227775703 > ./result_8chains/node456_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_0 -p 299 -st none -pt topic456_3_0 -u 0.014982166879858372 > ./result_8chains/node456_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_0 -p 470 -st none -pt topic456_4_0 -u 0.008810290217267092 > ./result_8chains/node456_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_0 -p 571 -st none -pt topic456_5_0 -u 0.002336312011860797 > ./result_8chains/node456_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_6_0 -p 676 -st none -pt topic456_6_0 -u 0.0026419386773483128 > ./result_8chains/node456_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_7_0 -p 790 -st none -pt topic456_7_0 -u 0.017178689761646534 > ./result_8chains/node456_7_0.txt &
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
    "./result_8chains/node456_0_0.txt 90"
    "./result_8chains/node456_0_2.txt 90"
    "./result_8chains/node456_1_0.txt 89"
    "./result_8chains/node456_1_2.txt 89"
    "./result_8chains/node456_2_0.txt 88"
    "./result_8chains/node456_2_2.txt 88"
    "./result_8chains/node456_3_0.txt 87"
    "./result_8chains/node456_3_2.txt 87"
    "./result_8chains/node456_4_0.txt 86"
    "./result_8chains/node456_4_2.txt 86"
    "./result_8chains/node456_5_0.txt 85"
    "./result_8chains/node456_5_2.txt 85"
    "./result_8chains/node456_6_0.txt 84"
    "./result_8chains/node456_6_2.txt 84"
    "./result_8chains/node456_7_0.txt 83"
    "./result_8chains/node456_7_2.txt 83"
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
