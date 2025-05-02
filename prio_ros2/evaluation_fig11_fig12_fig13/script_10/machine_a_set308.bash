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
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_2 -p 22 -st topic308_0_1 -pt None -u 1.559515337884454e-05 > ./result_10chains/node308_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_2 -p 51 -st topic308_1_1 -pt None -u 0.012159776610942308 > ./result_10chains/node308_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_2 -p 267 -st topic308_2_1 -pt None -u 0.003996986361500365 > ./result_10chains/node308_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_2 -p 371 -st topic308_3_1 -pt None -u 0.009499263069789876 > ./result_10chains/node308_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_2 -p 482 -st topic308_4_1 -pt None -u 0.029349487327631707 > ./result_10chains/node308_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_2 -p 668 -st topic308_5_1 -pt None -u 0.017547604437754327 > ./result_10chains/node308_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_6_2 -p 675 -st topic308_6_1 -pt None -u 0.04326673421488292 > ./result_10chains/node308_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_7_2 -p 690 -st topic308_7_1 -pt None -u 0.013693814974258665 > ./result_10chains/node308_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_8_2 -p 808 -st topic308_8_1 -pt None -u 0.01653247124967574 > ./result_10chains/node308_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_9_2 -p 925 -st topic308_9_1 -pt None -u 0.03373705773355711 > ./result_10chains/node308_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_0 -p 22 -st none -pt topic308_0_0 -u 0.012777983845718988 > ./result_10chains/node308_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_0 -p 51 -st none -pt topic308_1_0 -u 0.004746139954788231 > ./result_10chains/node308_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_0 -p 267 -st none -pt topic308_2_0 -u 0.0033651002946814557 > ./result_10chains/node308_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_0 -p 371 -st none -pt topic308_3_0 -u 0.005007898543790468 > ./result_10chains/node308_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_0 -p 482 -st none -pt topic308_4_0 -u 0.011524627249673514 > ./result_10chains/node308_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_0 -p 668 -st none -pt topic308_5_0 -u 0.013432211119276116 > ./result_10chains/node308_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_6_0 -p 675 -st none -pt topic308_6_0 -u 0.0006642495114633218 > ./result_10chains/node308_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_7_0 -p 690 -st none -pt topic308_7_0 -u 0.11407103323512967 > ./result_10chains/node308_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_8_0 -p 808 -st none -pt topic308_8_0 -u 0.003126393020524823 > ./result_10chains/node308_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_9_0 -p 925 -st none -pt topic308_9_0 -u 0.0020278697527785286 > ./result_10chains/node308_9_0.txt &
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
    "./result_10chains/node308_0_0.txt 90"
    "./result_10chains/node308_0_2.txt 90"
    "./result_10chains/node308_1_0.txt 89"
    "./result_10chains/node308_1_2.txt 89"
    "./result_10chains/node308_2_0.txt 88"
    "./result_10chains/node308_2_2.txt 88"
    "./result_10chains/node308_3_0.txt 87"
    "./result_10chains/node308_3_2.txt 87"
    "./result_10chains/node308_4_0.txt 86"
    "./result_10chains/node308_4_2.txt 86"
    "./result_10chains/node308_5_0.txt 85"
    "./result_10chains/node308_5_2.txt 85"
    "./result_10chains/node308_6_0.txt 84"
    "./result_10chains/node308_6_2.txt 84"
    "./result_10chains/node308_7_0.txt 83"
    "./result_10chains/node308_7_2.txt 83"
    "./result_10chains/node308_8_0.txt 82"
    "./result_10chains/node308_8_2.txt 82"
    "./result_10chains/node308_9_0.txt 81"
    "./result_10chains/node308_9_2.txt 81"
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
