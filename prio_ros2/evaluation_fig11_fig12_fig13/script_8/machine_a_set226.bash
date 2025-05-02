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
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_2 -p 50 -st topic226_0_1 -pt None -u 0.024035850139996817 > ./result_8chains/node226_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_2 -p 185 -st topic226_1_1 -pt None -u 0.005410671273882117 > ./result_8chains/node226_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_2 -p 452 -st topic226_2_1 -pt None -u 0.04783169794190861 > ./result_8chains/node226_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_2 -p 499 -st topic226_3_1 -pt None -u 0.07249753729766939 > ./result_8chains/node226_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_2 -p 596 -st topic226_4_1 -pt None -u 0.023664062793515683 > ./result_8chains/node226_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_2 -p 688 -st topic226_5_1 -pt None -u 0.00531416597103021 > ./result_8chains/node226_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_2 -p 710 -st topic226_6_1 -pt None -u 0.005929433349734212 > ./result_8chains/node226_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_2 -p 816 -st topic226_7_1 -pt None -u 0.029662186489602393 > ./result_8chains/node226_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_0 -p 50 -st none -pt topic226_0_0 -u 0.009248049041138018 > ./result_8chains/node226_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_0 -p 185 -st none -pt topic226_1_0 -u 0.01064986390591055 > ./result_8chains/node226_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_0 -p 452 -st none -pt topic226_2_0 -u 0.024087886418193316 > ./result_8chains/node226_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_0 -p 499 -st none -pt topic226_3_0 -u 0.01051072286340532 > ./result_8chains/node226_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_0 -p 596 -st none -pt topic226_4_0 -u 0.023753817273653832 > ./result_8chains/node226_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_0 -p 688 -st none -pt topic226_5_0 -u 0.02006181702216775 > ./result_8chains/node226_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_0 -p 710 -st none -pt topic226_6_0 -u 0.01881666541864964 > ./result_8chains/node226_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_0 -p 816 -st none -pt topic226_7_0 -u 0.017884862049344002 > ./result_8chains/node226_7_0.txt &
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
    "./result_8chains/node226_0_0.txt 90"
    "./result_8chains/node226_0_2.txt 90"
    "./result_8chains/node226_1_0.txt 89"
    "./result_8chains/node226_1_2.txt 89"
    "./result_8chains/node226_2_0.txt 88"
    "./result_8chains/node226_2_2.txt 88"
    "./result_8chains/node226_3_0.txt 87"
    "./result_8chains/node226_3_2.txt 87"
    "./result_8chains/node226_4_0.txt 86"
    "./result_8chains/node226_4_2.txt 86"
    "./result_8chains/node226_5_0.txt 85"
    "./result_8chains/node226_5_2.txt 85"
    "./result_8chains/node226_6_0.txt 84"
    "./result_8chains/node226_6_2.txt 84"
    "./result_8chains/node226_7_0.txt 83"
    "./result_8chains/node226_7_2.txt 83"
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
