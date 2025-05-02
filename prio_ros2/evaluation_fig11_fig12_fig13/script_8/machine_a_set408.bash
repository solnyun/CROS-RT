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
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_2 -p 11 -st topic408_0_1 -pt None -u 0.004644769698683493 > ./result_8chains/node408_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_2 -p 262 -st topic408_1_1 -pt None -u 0.011762677931059118 > ./result_8chains/node408_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_2 -p 412 -st topic408_2_1 -pt None -u 0.008885711175636746 > ./result_8chains/node408_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_2 -p 459 -st topic408_3_1 -pt None -u 0.03395930445488027 > ./result_8chains/node408_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_2 -p 681 -st topic408_4_1 -pt None -u 0.035351912894961535 > ./result_8chains/node408_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_2 -p 818 -st topic408_5_1 -pt None -u 0.029531310321002924 > ./result_8chains/node408_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_6_2 -p 839 -st topic408_6_1 -pt None -u 0.05759685965099579 > ./result_8chains/node408_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_7_2 -p 924 -st topic408_7_1 -pt None -u 0.00047597414772221884 > ./result_8chains/node408_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_0 -p 11 -st none -pt topic408_0_0 -u 0.002484886635518213 > ./result_8chains/node408_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_0 -p 262 -st none -pt topic408_1_0 -u 0.008063200353632782 > ./result_8chains/node408_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_0 -p 412 -st none -pt topic408_2_0 -u 0.029201228310798688 > ./result_8chains/node408_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_0 -p 459 -st none -pt topic408_3_0 -u 0.016567233486899757 > ./result_8chains/node408_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_0 -p 681 -st none -pt topic408_4_0 -u 0.05862980466481449 > ./result_8chains/node408_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_0 -p 818 -st none -pt topic408_5_0 -u 0.015960839652702646 > ./result_8chains/node408_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_6_0 -p 839 -st none -pt topic408_6_0 -u 0.04447325976597734 > ./result_8chains/node408_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_7_0 -p 924 -st none -pt topic408_7_0 -u 0.0029896740831873835 > ./result_8chains/node408_7_0.txt &
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
    "./result_8chains/node408_0_0.txt 90"
    "./result_8chains/node408_0_2.txt 90"
    "./result_8chains/node408_1_0.txt 89"
    "./result_8chains/node408_1_2.txt 89"
    "./result_8chains/node408_2_0.txt 88"
    "./result_8chains/node408_2_2.txt 88"
    "./result_8chains/node408_3_0.txt 87"
    "./result_8chains/node408_3_2.txt 87"
    "./result_8chains/node408_4_0.txt 86"
    "./result_8chains/node408_4_2.txt 86"
    "./result_8chains/node408_5_0.txt 85"
    "./result_8chains/node408_5_2.txt 85"
    "./result_8chains/node408_6_0.txt 84"
    "./result_8chains/node408_6_2.txt 84"
    "./result_8chains/node408_7_0.txt 83"
    "./result_8chains/node408_7_2.txt 83"
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
