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
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_2 -p 44 -st topic120_0_1 -pt None -u 0.05939836817293742 > ./result_8chains/node120_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_2 -p 51 -st topic120_1_1 -pt None -u 0.017173714046645583 > ./result_8chains/node120_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_2 -p 526 -st topic120_2_1 -pt None -u 0.002236809418638297 > ./result_8chains/node120_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_2 -p 607 -st topic120_3_1 -pt None -u 0.0026518573796638356 > ./result_8chains/node120_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_2 -p 698 -st topic120_4_1 -pt None -u 0.02322538421763426 > ./result_8chains/node120_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_2 -p 716 -st topic120_5_1 -pt None -u 0.13681434939115714 > ./result_8chains/node120_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_6_2 -p 721 -st topic120_6_1 -pt None -u 0.022182705749090065 > ./result_8chains/node120_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_7_2 -p 960 -st topic120_7_1 -pt None -u 0.005952934113444427 > ./result_8chains/node120_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_0 -p 44 -st none -pt topic120_0_0 -u 0.007575113931872435 > ./result_8chains/node120_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_0 -p 51 -st none -pt topic120_1_0 -u 0.0064712180670526975 > ./result_8chains/node120_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_0 -p 526 -st none -pt topic120_2_0 -u 0.007814688545262849 > ./result_8chains/node120_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_0 -p 607 -st none -pt topic120_3_0 -u 0.021504975990285946 > ./result_8chains/node120_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_0 -p 698 -st none -pt topic120_4_0 -u 0.013105691148970644 > ./result_8chains/node120_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_0 -p 716 -st none -pt topic120_5_0 -u 0.00039506164240071806 > ./result_8chains/node120_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_6_0 -p 721 -st none -pt topic120_6_0 -u 0.028416690624973567 > ./result_8chains/node120_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_7_0 -p 960 -st none -pt topic120_7_0 -u 0.06095593703636806 > ./result_8chains/node120_7_0.txt &
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
    "./result_8chains/node120_0_0.txt 90"
    "./result_8chains/node120_0_2.txt 90"
    "./result_8chains/node120_1_0.txt 89"
    "./result_8chains/node120_1_2.txt 89"
    "./result_8chains/node120_2_0.txt 88"
    "./result_8chains/node120_2_2.txt 88"
    "./result_8chains/node120_3_0.txt 87"
    "./result_8chains/node120_3_2.txt 87"
    "./result_8chains/node120_4_0.txt 86"
    "./result_8chains/node120_4_2.txt 86"
    "./result_8chains/node120_5_0.txt 85"
    "./result_8chains/node120_5_2.txt 85"
    "./result_8chains/node120_6_0.txt 84"
    "./result_8chains/node120_6_2.txt 84"
    "./result_8chains/node120_7_0.txt 83"
    "./result_8chains/node120_7_2.txt 83"
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
