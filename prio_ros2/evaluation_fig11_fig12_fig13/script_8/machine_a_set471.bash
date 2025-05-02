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
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_2 -p 18 -st topic471_0_1 -pt None -u 0.030358410195966967 > ./result_8chains/node471_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_2 -p 259 -st topic471_1_1 -pt None -u 0.003208287607520899 > ./result_8chains/node471_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_2 -p 266 -st topic471_2_1 -pt None -u 0.02358925340606871 > ./result_8chains/node471_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_2 -p 395 -st topic471_3_1 -pt None -u 0.005641606914959851 > ./result_8chains/node471_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_2 -p 457 -st topic471_4_1 -pt None -u 0.020205213752707007 > ./result_8chains/node471_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_2 -p 555 -st topic471_5_1 -pt None -u 0.00033046288755167463 > ./result_8chains/node471_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_6_2 -p 630 -st topic471_6_1 -pt None -u 0.02031505537840185 > ./result_8chains/node471_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_7_2 -p 759 -st topic471_7_1 -pt None -u 0.010589473501312688 > ./result_8chains/node471_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_0 -p 18 -st none -pt topic471_0_0 -u 0.003073642879361127 > ./result_8chains/node471_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_0 -p 259 -st none -pt topic471_1_0 -u 0.0019565196062347745 > ./result_8chains/node471_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_0 -p 266 -st none -pt topic471_2_0 -u 0.013297502695151397 > ./result_8chains/node471_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_0 -p 395 -st none -pt topic471_3_0 -u 0.01116929001636291 > ./result_8chains/node471_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_0 -p 457 -st none -pt topic471_4_0 -u 0.00839317751648383 > ./result_8chains/node471_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_0 -p 555 -st none -pt topic471_5_0 -u 0.019067699756846357 > ./result_8chains/node471_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_6_0 -p 630 -st none -pt topic471_6_0 -u 0.03484174473362878 > ./result_8chains/node471_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_7_0 -p 759 -st none -pt topic471_7_0 -u 0.07707811155594593 > ./result_8chains/node471_7_0.txt &
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
    "./result_8chains/node471_0_0.txt 90"
    "./result_8chains/node471_0_2.txt 90"
    "./result_8chains/node471_1_0.txt 89"
    "./result_8chains/node471_1_2.txt 89"
    "./result_8chains/node471_2_0.txt 88"
    "./result_8chains/node471_2_2.txt 88"
    "./result_8chains/node471_3_0.txt 87"
    "./result_8chains/node471_3_2.txt 87"
    "./result_8chains/node471_4_0.txt 86"
    "./result_8chains/node471_4_2.txt 86"
    "./result_8chains/node471_5_0.txt 85"
    "./result_8chains/node471_5_2.txt 85"
    "./result_8chains/node471_6_0.txt 84"
    "./result_8chains/node471_6_2.txt 84"
    "./result_8chains/node471_7_0.txt 83"
    "./result_8chains/node471_7_2.txt 83"
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
