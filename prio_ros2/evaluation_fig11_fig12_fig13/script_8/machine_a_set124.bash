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
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_2 -p 92 -st topic124_0_1 -pt None -u 0.012809339686164212 > ./result_8chains/node124_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_2 -p 111 -st topic124_1_1 -pt None -u 0.01714671065041634 > ./result_8chains/node124_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_2 -p 313 -st topic124_2_1 -pt None -u 0.10838381982720849 > ./result_8chains/node124_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_2 -p 361 -st topic124_3_1 -pt None -u 0.0023538610452788766 > ./result_8chains/node124_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_2 -p 468 -st topic124_4_1 -pt None -u 6.85834930884699e-05 > ./result_8chains/node124_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_2 -p 626 -st topic124_5_1 -pt None -u 0.006307368150799006 > ./result_8chains/node124_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_2 -p 654 -st topic124_6_1 -pt None -u 0.011163129728809491 > ./result_8chains/node124_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_2 -p 775 -st topic124_7_1 -pt None -u 3.535646830276089e-05 > ./result_8chains/node124_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_0 -p 92 -st none -pt topic124_0_0 -u 0.0009489215845147614 > ./result_8chains/node124_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_0 -p 111 -st none -pt topic124_1_0 -u 0.010579576944378388 > ./result_8chains/node124_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_0 -p 313 -st none -pt topic124_2_0 -u 0.008003736790062221 > ./result_8chains/node124_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_0 -p 361 -st none -pt topic124_3_0 -u 0.03084820846858949 > ./result_8chains/node124_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_0 -p 468 -st none -pt topic124_4_0 -u 0.005724047056786169 > ./result_8chains/node124_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_0 -p 626 -st none -pt topic124_5_0 -u 0.029928494585890586 > ./result_8chains/node124_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_0 -p 654 -st none -pt topic124_6_0 -u 0.009544807039918765 > ./result_8chains/node124_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_0 -p 775 -st none -pt topic124_7_0 -u 0.004440678026020259 > ./result_8chains/node124_7_0.txt &
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
    "./result_8chains/node124_0_0.txt 90"
    "./result_8chains/node124_0_2.txt 90"
    "./result_8chains/node124_1_0.txt 89"
    "./result_8chains/node124_1_2.txt 89"
    "./result_8chains/node124_2_0.txt 88"
    "./result_8chains/node124_2_2.txt 88"
    "./result_8chains/node124_3_0.txt 87"
    "./result_8chains/node124_3_2.txt 87"
    "./result_8chains/node124_4_0.txt 86"
    "./result_8chains/node124_4_2.txt 86"
    "./result_8chains/node124_5_0.txt 85"
    "./result_8chains/node124_5_2.txt 85"
    "./result_8chains/node124_6_0.txt 84"
    "./result_8chains/node124_6_2.txt 84"
    "./result_8chains/node124_7_0.txt 83"
    "./result_8chains/node124_7_2.txt 83"
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
