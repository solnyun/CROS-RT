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
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_2 -p 44 -st topic324_0_1 -pt None -u 0.014639171675501939 > ./result_10chains/node324_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_2 -p 74 -st topic324_1_1 -pt None -u 0.000996751547879926 > ./result_10chains/node324_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_2 -p 184 -st topic324_2_1 -pt None -u 0.017904552579388444 > ./result_10chains/node324_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_2 -p 240 -st topic324_3_1 -pt None -u 0.009310469930680854 > ./result_10chains/node324_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_2 -p 365 -st topic324_4_1 -pt None -u 0.01807569394409142 > ./result_10chains/node324_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_2 -p 489 -st topic324_5_1 -pt None -u 0.0021479522453176636 > ./result_10chains/node324_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_6_2 -p 556 -st topic324_6_1 -pt None -u 0.0231010731261041 > ./result_10chains/node324_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_7_2 -p 574 -st topic324_7_1 -pt None -u 0.010634391404445442 > ./result_10chains/node324_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_8_2 -p 879 -st topic324_8_1 -pt None -u 0.0025513630957337413 > ./result_10chains/node324_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_9_2 -p 976 -st topic324_9_1 -pt None -u 0.05266812605581156 > ./result_10chains/node324_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_0_0 -p 44 -st none -pt topic324_0_0 -u 0.018337953653255468 > ./result_10chains/node324_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_1_0 -p 74 -st none -pt topic324_1_0 -u 0.004087571182943228 > ./result_10chains/node324_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_2_0 -p 184 -st none -pt topic324_2_0 -u 0.05784627321447411 > ./result_10chains/node324_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_3_0 -p 240 -st none -pt topic324_3_0 -u 0.016883854097618334 > ./result_10chains/node324_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_4_0 -p 365 -st none -pt topic324_4_0 -u 0.014107304343403404 > ./result_10chains/node324_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_5_0 -p 489 -st none -pt topic324_5_0 -u 0.016377998310725506 > ./result_10chains/node324_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_6_0 -p 556 -st none -pt topic324_6_0 -u 0.0071507536381449355 > ./result_10chains/node324_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_7_0 -p 574 -st none -pt topic324_7_0 -u 0.0753210359670673 > ./result_10chains/node324_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node324_8_0 -p 879 -st none -pt topic324_8_0 -u 0.020542497130914175 > ./result_10chains/node324_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node324_9_0 -p 976 -st none -pt topic324_9_0 -u 0.008459922011203574 > ./result_10chains/node324_9_0.txt &
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
    "./result_10chains/node324_0_0.txt 90"
    "./result_10chains/node324_0_2.txt 90"
    "./result_10chains/node324_1_0.txt 89"
    "./result_10chains/node324_1_2.txt 89"
    "./result_10chains/node324_2_0.txt 88"
    "./result_10chains/node324_2_2.txt 88"
    "./result_10chains/node324_3_0.txt 87"
    "./result_10chains/node324_3_2.txt 87"
    "./result_10chains/node324_4_0.txt 86"
    "./result_10chains/node324_4_2.txt 86"
    "./result_10chains/node324_5_0.txt 85"
    "./result_10chains/node324_5_2.txt 85"
    "./result_10chains/node324_6_0.txt 84"
    "./result_10chains/node324_6_2.txt 84"
    "./result_10chains/node324_7_0.txt 83"
    "./result_10chains/node324_7_2.txt 83"
    "./result_10chains/node324_8_0.txt 82"
    "./result_10chains/node324_8_2.txt 82"
    "./result_10chains/node324_9_0.txt 81"
    "./result_10chains/node324_9_2.txt 81"
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
