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
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_2 -p 152 -st topic400_0_1 -pt None -u 0.012035680103785806 > ./result_10chains/node400_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_2 -p 179 -st topic400_1_1 -pt None -u 0.02343433998397032 > ./result_10chains/node400_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_2 -p 192 -st topic400_2_1 -pt None -u 0.017300462255762705 > ./result_10chains/node400_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_2 -p 319 -st topic400_3_1 -pt None -u 0.001985574320387151 > ./result_10chains/node400_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_2 -p 338 -st topic400_4_1 -pt None -u 0.002208154780439453 > ./result_10chains/node400_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_2 -p 434 -st topic400_5_1 -pt None -u 0.022309930639002412 > ./result_10chains/node400_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_6_2 -p 490 -st topic400_6_1 -pt None -u 0.010403613974985182 > ./result_10chains/node400_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_7_2 -p 497 -st topic400_7_1 -pt None -u 0.001752331844028121 > ./result_10chains/node400_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_8_2 -p 629 -st topic400_8_1 -pt None -u 0.010972249259325217 > ./result_10chains/node400_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_9_2 -p 661 -st topic400_9_1 -pt None -u 0.008276713638901492 > ./result_10chains/node400_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_0 -p 152 -st none -pt topic400_0_0 -u 0.007067093395900836 > ./result_10chains/node400_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_0 -p 179 -st none -pt topic400_1_0 -u 0.0339809935496464 > ./result_10chains/node400_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_0 -p 192 -st none -pt topic400_2_0 -u 0.0043212946876198255 > ./result_10chains/node400_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_0 -p 319 -st none -pt topic400_3_0 -u 0.02153312076752295 > ./result_10chains/node400_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_4_0 -p 338 -st none -pt topic400_4_0 -u 0.03256019381949343 > ./result_10chains/node400_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_5_0 -p 434 -st none -pt topic400_5_0 -u 0.04235208532776913 > ./result_10chains/node400_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_6_0 -p 490 -st none -pt topic400_6_0 -u 0.02319081430801434 > ./result_10chains/node400_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_7_0 -p 497 -st none -pt topic400_7_0 -u 0.007561320638179839 > ./result_10chains/node400_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_8_0 -p 629 -st none -pt topic400_8_0 -u 0.02695612602901256 > ./result_10chains/node400_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_9_0 -p 661 -st none -pt topic400_9_0 -u 0.005847817851899514 > ./result_10chains/node400_9_0.txt &
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
    "./result_10chains/node400_0_0.txt 90"
    "./result_10chains/node400_0_2.txt 90"
    "./result_10chains/node400_1_0.txt 89"
    "./result_10chains/node400_1_2.txt 89"
    "./result_10chains/node400_2_0.txt 88"
    "./result_10chains/node400_2_2.txt 88"
    "./result_10chains/node400_3_0.txt 87"
    "./result_10chains/node400_3_2.txt 87"
    "./result_10chains/node400_4_0.txt 86"
    "./result_10chains/node400_4_2.txt 86"
    "./result_10chains/node400_5_0.txt 85"
    "./result_10chains/node400_5_2.txt 85"
    "./result_10chains/node400_6_0.txt 84"
    "./result_10chains/node400_6_2.txt 84"
    "./result_10chains/node400_7_0.txt 83"
    "./result_10chains/node400_7_2.txt 83"
    "./result_10chains/node400_8_0.txt 82"
    "./result_10chains/node400_8_2.txt 82"
    "./result_10chains/node400_9_0.txt 81"
    "./result_10chains/node400_9_2.txt 81"
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
