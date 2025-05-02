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
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_2 -p 94 -st topic87_0_1 -pt None -u 0.001325582959134597 > ./result_10chains/node87_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_2 -p 150 -st topic87_1_1 -pt None -u 0.03892376002157094 > ./result_10chains/node87_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_2 -p 444 -st topic87_2_1 -pt None -u 0.0019084639796658198 > ./result_10chains/node87_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_2 -p 452 -st topic87_3_1 -pt None -u 0.0006006388616144331 > ./result_10chains/node87_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_2 -p 476 -st topic87_4_1 -pt None -u 0.01852776833486694 > ./result_10chains/node87_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_2 -p 512 -st topic87_5_1 -pt None -u 0.017945117294402207 > ./result_10chains/node87_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_2 -p 595 -st topic87_6_1 -pt None -u 0.007054988263025086 > ./result_10chains/node87_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_2 -p 794 -st topic87_7_1 -pt None -u 0.010873953818811705 > ./result_10chains/node87_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_8_2 -p 881 -st topic87_8_1 -pt None -u 0.00942946782621406 > ./result_10chains/node87_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_9_2 -p 893 -st topic87_9_1 -pt None -u 0.0017821610303197775 > ./result_10chains/node87_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_0 -p 94 -st none -pt topic87_0_0 -u 0.0028444495764952116 > ./result_10chains/node87_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_0 -p 150 -st none -pt topic87_1_0 -u 0.012904895206139466 > ./result_10chains/node87_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_0 -p 444 -st none -pt topic87_2_0 -u 0.09306367429672191 > ./result_10chains/node87_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_0 -p 452 -st none -pt topic87_3_0 -u 0.018218915877073694 > ./result_10chains/node87_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_0 -p 476 -st none -pt topic87_4_0 -u 0.001742661335736806 > ./result_10chains/node87_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_0 -p 512 -st none -pt topic87_5_0 -u 0.009862902823712327 > ./result_10chains/node87_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_0 -p 595 -st none -pt topic87_6_0 -u 0.008226501197739156 > ./result_10chains/node87_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_0 -p 794 -st none -pt topic87_7_0 -u 0.03473425025570924 > ./result_10chains/node87_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_8_0 -p 881 -st none -pt topic87_8_0 -u 0.05329009530449702 > ./result_10chains/node87_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_9_0 -p 893 -st none -pt topic87_9_0 -u 0.02462100694232837 > ./result_10chains/node87_9_0.txt &
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
    "./result_10chains/node87_0_0.txt 90"
    "./result_10chains/node87_0_2.txt 90"
    "./result_10chains/node87_1_0.txt 89"
    "./result_10chains/node87_1_2.txt 89"
    "./result_10chains/node87_2_0.txt 88"
    "./result_10chains/node87_2_2.txt 88"
    "./result_10chains/node87_3_0.txt 87"
    "./result_10chains/node87_3_2.txt 87"
    "./result_10chains/node87_4_0.txt 86"
    "./result_10chains/node87_4_2.txt 86"
    "./result_10chains/node87_5_0.txt 85"
    "./result_10chains/node87_5_2.txt 85"
    "./result_10chains/node87_6_0.txt 84"
    "./result_10chains/node87_6_2.txt 84"
    "./result_10chains/node87_7_0.txt 83"
    "./result_10chains/node87_7_2.txt 83"
    "./result_10chains/node87_8_0.txt 82"
    "./result_10chains/node87_8_2.txt 82"
    "./result_10chains/node87_9_0.txt 81"
    "./result_10chains/node87_9_2.txt 81"
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
