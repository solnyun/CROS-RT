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
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_2 -p 103 -st topic457_0_1 -pt None -u 0.02641539832154821 > ./result_10chains/node457_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_2 -p 133 -st topic457_1_1 -pt None -u 0.011414079098991503 > ./result_10chains/node457_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_2 -p 154 -st topic457_2_1 -pt None -u 0.01838777916835338 > ./result_10chains/node457_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_2 -p 442 -st topic457_3_1 -pt None -u 0.002549586908999091 > ./result_10chains/node457_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_2 -p 531 -st topic457_4_1 -pt None -u 0.07238198110274979 > ./result_10chains/node457_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_2 -p 543 -st topic457_5_1 -pt None -u 0.012538528603527943 > ./result_10chains/node457_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_6_2 -p 587 -st topic457_6_1 -pt None -u 0.005773405722730801 > ./result_10chains/node457_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_7_2 -p 655 -st topic457_7_1 -pt None -u 0.00018972066929881515 > ./result_10chains/node457_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_8_2 -p 679 -st topic457_8_1 -pt None -u 0.0031906434090632624 > ./result_10chains/node457_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_9_2 -p 879 -st topic457_9_1 -pt None -u 0.0033587101151133555 > ./result_10chains/node457_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_0 -p 103 -st none -pt topic457_0_0 -u 0.009029666908537293 > ./result_10chains/node457_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_0 -p 133 -st none -pt topic457_1_0 -u 0.011365606335707157 > ./result_10chains/node457_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_0 -p 154 -st none -pt topic457_2_0 -u 0.02291542616113479 > ./result_10chains/node457_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_0 -p 442 -st none -pt topic457_3_0 -u 0.007814048287296482 > ./result_10chains/node457_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_0 -p 531 -st none -pt topic457_4_0 -u 0.008150575516034542 > ./result_10chains/node457_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_0 -p 543 -st none -pt topic457_5_0 -u 0.01381867817796889 > ./result_10chains/node457_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_6_0 -p 587 -st none -pt topic457_6_0 -u 0.011084743669281721 > ./result_10chains/node457_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_7_0 -p 655 -st none -pt topic457_7_0 -u 0.00884786528022169 > ./result_10chains/node457_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_8_0 -p 679 -st none -pt topic457_8_0 -u 0.03905194576307355 > ./result_10chains/node457_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_9_0 -p 879 -st none -pt topic457_9_0 -u 0.011514229670619366 > ./result_10chains/node457_9_0.txt &
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
    "./result_10chains/node457_0_0.txt 90"
    "./result_10chains/node457_0_2.txt 90"
    "./result_10chains/node457_1_0.txt 89"
    "./result_10chains/node457_1_2.txt 89"
    "./result_10chains/node457_2_0.txt 88"
    "./result_10chains/node457_2_2.txt 88"
    "./result_10chains/node457_3_0.txt 87"
    "./result_10chains/node457_3_2.txt 87"
    "./result_10chains/node457_4_0.txt 86"
    "./result_10chains/node457_4_2.txt 86"
    "./result_10chains/node457_5_0.txt 85"
    "./result_10chains/node457_5_2.txt 85"
    "./result_10chains/node457_6_0.txt 84"
    "./result_10chains/node457_6_2.txt 84"
    "./result_10chains/node457_7_0.txt 83"
    "./result_10chains/node457_7_2.txt 83"
    "./result_10chains/node457_8_0.txt 82"
    "./result_10chains/node457_8_2.txt 82"
    "./result_10chains/node457_9_0.txt 81"
    "./result_10chains/node457_9_2.txt 81"
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
