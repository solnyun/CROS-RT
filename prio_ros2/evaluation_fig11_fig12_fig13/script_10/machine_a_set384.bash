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
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_2 -p 150 -st topic384_0_1 -pt None -u 0.010370191855728406 > ./result_10chains/node384_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_2 -p 379 -st topic384_1_1 -pt None -u 0.005078361241367846 > ./result_10chains/node384_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_2 -p 392 -st topic384_2_1 -pt None -u 0.0349818318936122 > ./result_10chains/node384_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_2 -p 433 -st topic384_3_1 -pt None -u 0.028777627272376538 > ./result_10chains/node384_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_2 -p 568 -st topic384_4_1 -pt None -u 0.016400132951412405 > ./result_10chains/node384_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_2 -p 588 -st topic384_5_1 -pt None -u 0.030646389254768064 > ./result_10chains/node384_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_6_2 -p 627 -st topic384_6_1 -pt None -u 0.04265715280412591 > ./result_10chains/node384_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_7_2 -p 653 -st topic384_7_1 -pt None -u 0.0035430496547159546 > ./result_10chains/node384_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_8_2 -p 723 -st topic384_8_1 -pt None -u 0.0015602734531721951 > ./result_10chains/node384_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_9_2 -p 852 -st topic384_9_1 -pt None -u 0.028198886456664195 > ./result_10chains/node384_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_0 -p 150 -st none -pt topic384_0_0 -u 0.006450665618409457 > ./result_10chains/node384_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_0 -p 379 -st none -pt topic384_1_0 -u 0.04949534475417061 > ./result_10chains/node384_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_0 -p 392 -st none -pt topic384_2_0 -u 0.0027838539355489744 > ./result_10chains/node384_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_0 -p 433 -st none -pt topic384_3_0 -u 0.019988080703306543 > ./result_10chains/node384_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_0 -p 568 -st none -pt topic384_4_0 -u 0.006205183148796256 > ./result_10chains/node384_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_0 -p 588 -st none -pt topic384_5_0 -u 0.011844431233904523 > ./result_10chains/node384_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_6_0 -p 627 -st none -pt topic384_6_0 -u 0.013623869025439356 > ./result_10chains/node384_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_7_0 -p 653 -st none -pt topic384_7_0 -u 0.023628752559730362 > ./result_10chains/node384_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_8_0 -p 723 -st none -pt topic384_8_0 -u 0.0008894815368519216 > ./result_10chains/node384_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_9_0 -p 852 -st none -pt topic384_9_0 -u 0.018075845785153734 > ./result_10chains/node384_9_0.txt &
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
    "./result_10chains/node384_0_0.txt 90"
    "./result_10chains/node384_0_2.txt 90"
    "./result_10chains/node384_1_0.txt 89"
    "./result_10chains/node384_1_2.txt 89"
    "./result_10chains/node384_2_0.txt 88"
    "./result_10chains/node384_2_2.txt 88"
    "./result_10chains/node384_3_0.txt 87"
    "./result_10chains/node384_3_2.txt 87"
    "./result_10chains/node384_4_0.txt 86"
    "./result_10chains/node384_4_2.txt 86"
    "./result_10chains/node384_5_0.txt 85"
    "./result_10chains/node384_5_2.txt 85"
    "./result_10chains/node384_6_0.txt 84"
    "./result_10chains/node384_6_2.txt 84"
    "./result_10chains/node384_7_0.txt 83"
    "./result_10chains/node384_7_2.txt 83"
    "./result_10chains/node384_8_0.txt 82"
    "./result_10chains/node384_8_2.txt 82"
    "./result_10chains/node384_9_0.txt 81"
    "./result_10chains/node384_9_2.txt 81"
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
