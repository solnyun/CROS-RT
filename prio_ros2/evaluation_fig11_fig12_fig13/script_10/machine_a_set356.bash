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
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_2 -p 52 -st topic356_0_1 -pt None -u 0.003699177830863043 > ./result_10chains/node356_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_2 -p 63 -st topic356_1_1 -pt None -u 8.28600613601016e-05 > ./result_10chains/node356_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_2 -p 138 -st topic356_2_1 -pt None -u 0.025577202996257653 > ./result_10chains/node356_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_2 -p 229 -st topic356_3_1 -pt None -u 0.005953590703131562 > ./result_10chains/node356_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_2 -p 325 -st topic356_4_1 -pt None -u 0.0138741953258536 > ./result_10chains/node356_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_2 -p 573 -st topic356_5_1 -pt None -u 0.022762417702514165 > ./result_10chains/node356_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_2 -p 636 -st topic356_6_1 -pt None -u 0.0031820663208975697 > ./result_10chains/node356_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_2 -p 677 -st topic356_7_1 -pt None -u 0.002137878709650737 > ./result_10chains/node356_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_8_2 -p 727 -st topic356_8_1 -pt None -u 0.09859793042189652 > ./result_10chains/node356_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_9_2 -p 782 -st topic356_9_1 -pt None -u 0.019482402251835628 > ./result_10chains/node356_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_0 -p 52 -st none -pt topic356_0_0 -u 0.02349505314252931 > ./result_10chains/node356_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_0 -p 63 -st none -pt topic356_1_0 -u 0.003605396125790916 > ./result_10chains/node356_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_0 -p 138 -st none -pt topic356_2_0 -u 0.002236883901269915 > ./result_10chains/node356_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_0 -p 229 -st none -pt topic356_3_0 -u 0.029803269661806298 > ./result_10chains/node356_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_0 -p 325 -st none -pt topic356_4_0 -u 0.014054092999152001 > ./result_10chains/node356_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_0 -p 573 -st none -pt topic356_5_0 -u 0.03349979461620886 > ./result_10chains/node356_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_0 -p 636 -st none -pt topic356_6_0 -u 0.005074481869159375 > ./result_10chains/node356_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_0 -p 677 -st none -pt topic356_7_0 -u 0.030760501629449488 > ./result_10chains/node356_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_8_0 -p 727 -st none -pt topic356_8_0 -u 0.0043689525342197055 > ./result_10chains/node356_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_9_0 -p 782 -st none -pt topic356_9_0 -u 0.009185548881049537 > ./result_10chains/node356_9_0.txt &
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
    "./result_10chains/node356_0_0.txt 90"
    "./result_10chains/node356_0_2.txt 90"
    "./result_10chains/node356_1_0.txt 89"
    "./result_10chains/node356_1_2.txt 89"
    "./result_10chains/node356_2_0.txt 88"
    "./result_10chains/node356_2_2.txt 88"
    "./result_10chains/node356_3_0.txt 87"
    "./result_10chains/node356_3_2.txt 87"
    "./result_10chains/node356_4_0.txt 86"
    "./result_10chains/node356_4_2.txt 86"
    "./result_10chains/node356_5_0.txt 85"
    "./result_10chains/node356_5_2.txt 85"
    "./result_10chains/node356_6_0.txt 84"
    "./result_10chains/node356_6_2.txt 84"
    "./result_10chains/node356_7_0.txt 83"
    "./result_10chains/node356_7_2.txt 83"
    "./result_10chains/node356_8_0.txt 82"
    "./result_10chains/node356_8_2.txt 82"
    "./result_10chains/node356_9_0.txt 81"
    "./result_10chains/node356_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
