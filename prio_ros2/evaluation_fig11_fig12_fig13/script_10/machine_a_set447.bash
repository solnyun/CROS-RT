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
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_2 -p 37 -st topic447_0_1 -pt None -u 0.005648874918202373 > ./result_10chains/node447_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_2 -p 40 -st topic447_1_1 -pt None -u 0.076249309708384 > ./result_10chains/node447_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_2 -p 41 -st topic447_2_1 -pt None -u 0.04008223689162166 > ./result_10chains/node447_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_2 -p 251 -st topic447_3_1 -pt None -u 0.010051730030166017 > ./result_10chains/node447_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_2 -p 302 -st topic447_4_1 -pt None -u 5.9376084201728796e-05 > ./result_10chains/node447_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_2 -p 408 -st topic447_5_1 -pt None -u 0.04685080933527899 > ./result_10chains/node447_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_6_2 -p 578 -st topic447_6_1 -pt None -u 0.016101651281336615 > ./result_10chains/node447_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_7_2 -p 631 -st topic447_7_1 -pt None -u 0.0035048281107258883 > ./result_10chains/node447_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_8_2 -p 696 -st topic447_8_1 -pt None -u 0.016381980563806436 > ./result_10chains/node447_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_9_2 -p 744 -st topic447_9_1 -pt None -u 0.00016093388333174297 > ./result_10chains/node447_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_0 -p 37 -st none -pt topic447_0_0 -u 0.023657135389142936 > ./result_10chains/node447_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_0 -p 40 -st none -pt topic447_1_0 -u 0.005056810543898671 > ./result_10chains/node447_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_0 -p 41 -st none -pt topic447_2_0 -u 0.0017185255113632558 > ./result_10chains/node447_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_0 -p 251 -st none -pt topic447_3_0 -u 0.003831897519056826 > ./result_10chains/node447_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_0 -p 302 -st none -pt topic447_4_0 -u 0.017786377902583084 > ./result_10chains/node447_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_0 -p 408 -st none -pt topic447_5_0 -u 0.005747379678048781 > ./result_10chains/node447_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_6_0 -p 578 -st none -pt topic447_6_0 -u 0.009111267207561807 > ./result_10chains/node447_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_7_0 -p 631 -st none -pt topic447_7_0 -u 0.03803090110444052 > ./result_10chains/node447_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_8_0 -p 696 -st none -pt topic447_8_0 -u 0.027178029748027577 > ./result_10chains/node447_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_9_0 -p 744 -st none -pt topic447_9_0 -u 0.009167283028548731 > ./result_10chains/node447_9_0.txt &
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
    "./result_10chains/node447_0_0.txt 90"
    "./result_10chains/node447_0_2.txt 90"
    "./result_10chains/node447_1_0.txt 89"
    "./result_10chains/node447_1_2.txt 89"
    "./result_10chains/node447_2_0.txt 88"
    "./result_10chains/node447_2_2.txt 88"
    "./result_10chains/node447_3_0.txt 87"
    "./result_10chains/node447_3_2.txt 87"
    "./result_10chains/node447_4_0.txt 86"
    "./result_10chains/node447_4_2.txt 86"
    "./result_10chains/node447_5_0.txt 85"
    "./result_10chains/node447_5_2.txt 85"
    "./result_10chains/node447_6_0.txt 84"
    "./result_10chains/node447_6_2.txt 84"
    "./result_10chains/node447_7_0.txt 83"
    "./result_10chains/node447_7_2.txt 83"
    "./result_10chains/node447_8_0.txt 82"
    "./result_10chains/node447_8_2.txt 82"
    "./result_10chains/node447_9_0.txt 81"
    "./result_10chains/node447_9_2.txt 81"
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
