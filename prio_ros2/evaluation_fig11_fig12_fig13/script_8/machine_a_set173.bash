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
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_2 -p 44 -st topic173_0_1 -pt None -u 0.03062805737877583 > ./result_8chains/node173_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_2 -p 148 -st topic173_1_1 -pt None -u 0.023051548437908187 > ./result_8chains/node173_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_2 -p 363 -st topic173_2_1 -pt None -u 0.08319834097986711 > ./result_8chains/node173_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_2 -p 437 -st topic173_3_1 -pt None -u 0.09383739648293418 > ./result_8chains/node173_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_2 -p 512 -st topic173_4_1 -pt None -u 0.013189134260685548 > ./result_8chains/node173_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_2 -p 608 -st topic173_5_1 -pt None -u 0.002658169424961679 > ./result_8chains/node173_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_6_2 -p 709 -st topic173_6_1 -pt None -u 0.016390965879665986 > ./result_8chains/node173_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_7_2 -p 824 -st topic173_7_1 -pt None -u 0.00333866363782125 > ./result_8chains/node173_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_0_0 -p 44 -st none -pt topic173_0_0 -u 0.002298244471499622 > ./result_8chains/node173_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_1_0 -p 148 -st none -pt topic173_1_0 -u 0.0009494750629470139 > ./result_8chains/node173_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_2_0 -p 363 -st none -pt topic173_2_0 -u 0.032118517681994085 > ./result_8chains/node173_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_3_0 -p 437 -st none -pt topic173_3_0 -u 0.03310836947627438 > ./result_8chains/node173_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_4_0 -p 512 -st none -pt topic173_4_0 -u 0.01577499375357544 > ./result_8chains/node173_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_5_0 -p 608 -st none -pt topic173_5_0 -u 0.0026865548142798318 > ./result_8chains/node173_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node173_6_0 -p 709 -st none -pt topic173_6_0 -u 0.025326361023776445 > ./result_8chains/node173_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node173_7_0 -p 824 -st none -pt topic173_7_0 -u 0.008562678974323031 > ./result_8chains/node173_7_0.txt &
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
    "./result_8chains/node173_0_0.txt 90"
    "./result_8chains/node173_0_2.txt 90"
    "./result_8chains/node173_1_0.txt 89"
    "./result_8chains/node173_1_2.txt 89"
    "./result_8chains/node173_2_0.txt 88"
    "./result_8chains/node173_2_2.txt 88"
    "./result_8chains/node173_3_0.txt 87"
    "./result_8chains/node173_3_2.txt 87"
    "./result_8chains/node173_4_0.txt 86"
    "./result_8chains/node173_4_2.txt 86"
    "./result_8chains/node173_5_0.txt 85"
    "./result_8chains/node173_5_2.txt 85"
    "./result_8chains/node173_6_0.txt 84"
    "./result_8chains/node173_6_2.txt 84"
    "./result_8chains/node173_7_0.txt 83"
    "./result_8chains/node173_7_2.txt 83"
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
