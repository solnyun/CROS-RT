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
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_2 -p 45 -st topic227_0_1 -pt None -u 0.010207888949249733 > ./result_8chains/node227_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_2 -p 211 -st topic227_1_1 -pt None -u 0.052927923619402795 > ./result_8chains/node227_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_2 -p 229 -st topic227_2_1 -pt None -u 0.01433610381725181 > ./result_8chains/node227_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_2 -p 335 -st topic227_3_1 -pt None -u 0.06805696126964361 > ./result_8chains/node227_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_2 -p 755 -st topic227_4_1 -pt None -u 0.011751757701933374 > ./result_8chains/node227_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_2 -p 898 -st topic227_5_1 -pt None -u 0.040721396603135326 > ./result_8chains/node227_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_2 -p 902 -st topic227_6_1 -pt None -u 0.021036772639251508 > ./result_8chains/node227_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_2 -p 931 -st topic227_7_1 -pt None -u 0.00039256398386738856 > ./result_8chains/node227_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_0 -p 45 -st none -pt topic227_0_0 -u 0.03254146068556474 > ./result_8chains/node227_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_0 -p 211 -st none -pt topic227_1_0 -u 0.024133858112943052 > ./result_8chains/node227_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_0 -p 229 -st none -pt topic227_2_0 -u 0.021392633531369 > ./result_8chains/node227_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_0 -p 335 -st none -pt topic227_3_0 -u 0.008676976778407897 > ./result_8chains/node227_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_0 -p 755 -st none -pt topic227_4_0 -u 0.006912246395722577 > ./result_8chains/node227_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_0 -p 898 -st none -pt topic227_5_0 -u 0.011679086057819643 > ./result_8chains/node227_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_0 -p 902 -st none -pt topic227_6_0 -u 0.01702518948563629 > ./result_8chains/node227_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_0 -p 931 -st none -pt topic227_7_0 -u 0.014965422371364712 > ./result_8chains/node227_7_0.txt &
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
    "./result_8chains/node227_0_0.txt 90"
    "./result_8chains/node227_0_2.txt 90"
    "./result_8chains/node227_1_0.txt 89"
    "./result_8chains/node227_1_2.txt 89"
    "./result_8chains/node227_2_0.txt 88"
    "./result_8chains/node227_2_2.txt 88"
    "./result_8chains/node227_3_0.txt 87"
    "./result_8chains/node227_3_2.txt 87"
    "./result_8chains/node227_4_0.txt 86"
    "./result_8chains/node227_4_2.txt 86"
    "./result_8chains/node227_5_0.txt 85"
    "./result_8chains/node227_5_2.txt 85"
    "./result_8chains/node227_6_0.txt 84"
    "./result_8chains/node227_6_2.txt 84"
    "./result_8chains/node227_7_0.txt 83"
    "./result_8chains/node227_7_2.txt 83"
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
