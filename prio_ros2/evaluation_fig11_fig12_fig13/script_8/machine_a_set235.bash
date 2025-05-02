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
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_2 -p 251 -st topic235_0_1 -pt None -u 0.0029924096734360583 > ./result_8chains/node235_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_2 -p 437 -st topic235_1_1 -pt None -u 0.041407632369466374 > ./result_8chains/node235_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_2 -p 453 -st topic235_2_1 -pt None -u 0.08849403905504405 > ./result_8chains/node235_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_2 -p 489 -st topic235_3_1 -pt None -u 0.010767351851270451 > ./result_8chains/node235_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_2 -p 721 -st topic235_4_1 -pt None -u 0.008548349323317134 > ./result_8chains/node235_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_2 -p 817 -st topic235_5_1 -pt None -u 0.006615679395808649 > ./result_8chains/node235_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_6_2 -p 892 -st topic235_6_1 -pt None -u 0.024519457240057455 > ./result_8chains/node235_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_7_2 -p 979 -st topic235_7_1 -pt None -u 0.028419594011919323 > ./result_8chains/node235_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_0 -p 251 -st none -pt topic235_0_0 -u 0.02077461531013819 > ./result_8chains/node235_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_0 -p 437 -st none -pt topic235_1_0 -u 0.008290945103082759 > ./result_8chains/node235_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_0 -p 453 -st none -pt topic235_2_0 -u 0.01013376382994946 > ./result_8chains/node235_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_0 -p 489 -st none -pt topic235_3_0 -u 0.0513291346923358 > ./result_8chains/node235_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_0 -p 721 -st none -pt topic235_4_0 -u 0.003668652033852887 > ./result_8chains/node235_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_0 -p 817 -st none -pt topic235_5_0 -u 0.0218866443422899 > ./result_8chains/node235_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_6_0 -p 892 -st none -pt topic235_6_0 -u 0.017171812312287343 > ./result_8chains/node235_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_7_0 -p 979 -st none -pt topic235_7_0 -u 0.006027411123414997 > ./result_8chains/node235_7_0.txt &
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
    "./result_8chains/node235_0_0.txt 90"
    "./result_8chains/node235_0_2.txt 90"
    "./result_8chains/node235_1_0.txt 89"
    "./result_8chains/node235_1_2.txt 89"
    "./result_8chains/node235_2_0.txt 88"
    "./result_8chains/node235_2_2.txt 88"
    "./result_8chains/node235_3_0.txt 87"
    "./result_8chains/node235_3_2.txt 87"
    "./result_8chains/node235_4_0.txt 86"
    "./result_8chains/node235_4_2.txt 86"
    "./result_8chains/node235_5_0.txt 85"
    "./result_8chains/node235_5_2.txt 85"
    "./result_8chains/node235_6_0.txt 84"
    "./result_8chains/node235_6_2.txt 84"
    "./result_8chains/node235_7_0.txt 83"
    "./result_8chains/node235_7_2.txt 83"
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
