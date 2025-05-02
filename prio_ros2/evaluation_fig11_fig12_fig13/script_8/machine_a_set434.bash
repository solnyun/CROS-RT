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
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_2 -p 135 -st topic434_0_1 -pt None -u 0.013295869756249523 > ./result_8chains/node434_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_2 -p 185 -st topic434_1_1 -pt None -u 0.0034257515481054823 > ./result_8chains/node434_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_2 -p 219 -st topic434_2_1 -pt None -u 0.003662689086194326 > ./result_8chains/node434_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_2 -p 222 -st topic434_3_1 -pt None -u 0.044735543545336265 > ./result_8chains/node434_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_2 -p 454 -st topic434_4_1 -pt None -u 0.006634042248458816 > ./result_8chains/node434_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_2 -p 569 -st topic434_5_1 -pt None -u 0.002054391365677616 > ./result_8chains/node434_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_6_2 -p 641 -st topic434_6_1 -pt None -u 0.04867697208088745 > ./result_8chains/node434_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_7_2 -p 873 -st topic434_7_1 -pt None -u 0.004434480082179286 > ./result_8chains/node434_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_0 -p 135 -st none -pt topic434_0_0 -u 0.008054344469802743 > ./result_8chains/node434_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_0 -p 185 -st none -pt topic434_1_0 -u 0.010778558711467101 > ./result_8chains/node434_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_0 -p 219 -st none -pt topic434_2_0 -u 0.005016943605957724 > ./result_8chains/node434_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_0 -p 222 -st none -pt topic434_3_0 -u 0.0381955570405077 > ./result_8chains/node434_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_0 -p 454 -st none -pt topic434_4_0 -u 0.02992609862005008 > ./result_8chains/node434_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_0 -p 569 -st none -pt topic434_5_0 -u 0.01261610817224032 > ./result_8chains/node434_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_6_0 -p 641 -st none -pt topic434_6_0 -u 0.022611786469256462 > ./result_8chains/node434_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_7_0 -p 873 -st none -pt topic434_7_0 -u 0.0019030689515352195 > ./result_8chains/node434_7_0.txt &
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
    "./result_8chains/node434_0_0.txt 90"
    "./result_8chains/node434_0_2.txt 90"
    "./result_8chains/node434_1_0.txt 89"
    "./result_8chains/node434_1_2.txt 89"
    "./result_8chains/node434_2_0.txt 88"
    "./result_8chains/node434_2_2.txt 88"
    "./result_8chains/node434_3_0.txt 87"
    "./result_8chains/node434_3_2.txt 87"
    "./result_8chains/node434_4_0.txt 86"
    "./result_8chains/node434_4_2.txt 86"
    "./result_8chains/node434_5_0.txt 85"
    "./result_8chains/node434_5_2.txt 85"
    "./result_8chains/node434_6_0.txt 84"
    "./result_8chains/node434_6_2.txt 84"
    "./result_8chains/node434_7_0.txt 83"
    "./result_8chains/node434_7_2.txt 83"
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
