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
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_2 -p 13 -st topic245_0_1 -pt None -u 0.001006004552097095 > ./result_8chains/node245_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_2 -p 88 -st topic245_1_1 -pt None -u 0.002281870703452482 > ./result_8chains/node245_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_2 -p 301 -st topic245_2_1 -pt None -u 0.024283924378440402 > ./result_8chains/node245_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_2 -p 360 -st topic245_3_1 -pt None -u 0.013558296253956548 > ./result_8chains/node245_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_2 -p 702 -st topic245_4_1 -pt None -u 0.029249502351189116 > ./result_8chains/node245_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_2 -p 848 -st topic245_5_1 -pt None -u 0.011128584042960618 > ./result_8chains/node245_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_2 -p 871 -st topic245_6_1 -pt None -u 0.034882836311149995 > ./result_8chains/node245_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_2 -p 899 -st topic245_7_1 -pt None -u 0.02231017910955803 > ./result_8chains/node245_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_0 -p 13 -st none -pt topic245_0_0 -u 0.05366909113322704 > ./result_8chains/node245_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_0 -p 88 -st none -pt topic245_1_0 -u 0.0034859672386119422 > ./result_8chains/node245_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_0 -p 301 -st none -pt topic245_2_0 -u 0.0006012181470824718 > ./result_8chains/node245_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_0 -p 360 -st none -pt topic245_3_0 -u 0.029664136520490603 > ./result_8chains/node245_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_0 -p 702 -st none -pt topic245_4_0 -u 0.016404674434851163 > ./result_8chains/node245_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_0 -p 848 -st none -pt topic245_5_0 -u 0.022854501773031444 > ./result_8chains/node245_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_0 -p 871 -st none -pt topic245_6_0 -u 0.009777604696888237 > ./result_8chains/node245_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_0 -p 899 -st none -pt topic245_7_0 -u 0.020130609191294703 > ./result_8chains/node245_7_0.txt &
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
    "./result_8chains/node245_0_0.txt 90"
    "./result_8chains/node245_0_2.txt 90"
    "./result_8chains/node245_1_0.txt 89"
    "./result_8chains/node245_1_2.txt 89"
    "./result_8chains/node245_2_0.txt 88"
    "./result_8chains/node245_2_2.txt 88"
    "./result_8chains/node245_3_0.txt 87"
    "./result_8chains/node245_3_2.txt 87"
    "./result_8chains/node245_4_0.txt 86"
    "./result_8chains/node245_4_2.txt 86"
    "./result_8chains/node245_5_0.txt 85"
    "./result_8chains/node245_5_2.txt 85"
    "./result_8chains/node245_6_0.txt 84"
    "./result_8chains/node245_6_2.txt 84"
    "./result_8chains/node245_7_0.txt 83"
    "./result_8chains/node245_7_2.txt 83"
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
