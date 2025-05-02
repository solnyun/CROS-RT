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
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_2 -p 94 -st topic268_0_1 -pt None -u 0.050747402895643556 > ./result_8chains/node268_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_2 -p 169 -st topic268_1_1 -pt None -u 0.0036824917270318336 > ./result_8chains/node268_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_2 -p 263 -st topic268_2_1 -pt None -u 0.016833969078686006 > ./result_8chains/node268_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_2 -p 394 -st topic268_3_1 -pt None -u 0.013906468890039186 > ./result_8chains/node268_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_2 -p 434 -st topic268_4_1 -pt None -u 0.04445769247021861 > ./result_8chains/node268_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_2 -p 684 -st topic268_5_1 -pt None -u 0.005905335541749157 > ./result_8chains/node268_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_6_2 -p 742 -st topic268_6_1 -pt None -u 0.011643582959135035 > ./result_8chains/node268_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_7_2 -p 979 -st topic268_7_1 -pt None -u 0.009820922457721374 > ./result_8chains/node268_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_0 -p 94 -st none -pt topic268_0_0 -u 0.01530054355637167 > ./result_8chains/node268_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_0 -p 169 -st none -pt topic268_1_0 -u 0.0010776534564426177 > ./result_8chains/node268_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_0 -p 263 -st none -pt topic268_2_0 -u 0.009445778075474864 > ./result_8chains/node268_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_0 -p 394 -st none -pt topic268_3_0 -u 0.08008454082340888 > ./result_8chains/node268_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_0 -p 434 -st none -pt topic268_4_0 -u 0.0019930299384414707 > ./result_8chains/node268_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_0 -p 684 -st none -pt topic268_5_0 -u 0.006200763462543862 > ./result_8chains/node268_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_6_0 -p 742 -st none -pt topic268_6_0 -u 0.024198046416107705 > ./result_8chains/node268_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_7_0 -p 979 -st none -pt topic268_7_0 -u 0.04357742966038884 > ./result_8chains/node268_7_0.txt &
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
    "./result_8chains/node268_0_0.txt 90"
    "./result_8chains/node268_0_2.txt 90"
    "./result_8chains/node268_1_0.txt 89"
    "./result_8chains/node268_1_2.txt 89"
    "./result_8chains/node268_2_0.txt 88"
    "./result_8chains/node268_2_2.txt 88"
    "./result_8chains/node268_3_0.txt 87"
    "./result_8chains/node268_3_2.txt 87"
    "./result_8chains/node268_4_0.txt 86"
    "./result_8chains/node268_4_2.txt 86"
    "./result_8chains/node268_5_0.txt 85"
    "./result_8chains/node268_5_2.txt 85"
    "./result_8chains/node268_6_0.txt 84"
    "./result_8chains/node268_6_2.txt 84"
    "./result_8chains/node268_7_0.txt 83"
    "./result_8chains/node268_7_2.txt 83"
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
