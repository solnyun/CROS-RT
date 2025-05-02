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
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_2 -p 74 -st topic306_0_1 -pt None -u 0.026583908610403217 > ./result_10chains/node306_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_2 -p 182 -st topic306_1_1 -pt None -u 0.015075913158511534 > ./result_10chains/node306_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_2 -p 196 -st topic306_2_1 -pt None -u 0.04733149656860308 > ./result_10chains/node306_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_2 -p 323 -st topic306_3_1 -pt None -u 0.00037948216345351504 > ./result_10chains/node306_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_2 -p 424 -st topic306_4_1 -pt None -u 0.011605575372746757 > ./result_10chains/node306_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_2 -p 478 -st topic306_5_1 -pt None -u 0.007487389183919918 > ./result_10chains/node306_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_2 -p 486 -st topic306_6_1 -pt None -u 0.00886764975264659 > ./result_10chains/node306_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_2 -p 724 -st topic306_7_1 -pt None -u 0.011678247708200834 > ./result_10chains/node306_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_8_2 -p 843 -st topic306_8_1 -pt None -u 0.018069381558672888 > ./result_10chains/node306_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_9_2 -p 908 -st topic306_9_1 -pt None -u 0.03625064244088869 > ./result_10chains/node306_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_0 -p 74 -st none -pt topic306_0_0 -u 0.002527186235164791 > ./result_10chains/node306_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_0 -p 182 -st none -pt topic306_1_0 -u 0.0029227874099654327 > ./result_10chains/node306_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_0 -p 196 -st none -pt topic306_2_0 -u 0.01591879720047068 > ./result_10chains/node306_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_0 -p 323 -st none -pt topic306_3_0 -u 0.030380184742886063 > ./result_10chains/node306_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_0 -p 424 -st none -pt topic306_4_0 -u 0.04181318700985953 > ./result_10chains/node306_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_0 -p 478 -st none -pt topic306_5_0 -u 0.009654394879664435 > ./result_10chains/node306_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_0 -p 486 -st none -pt topic306_6_0 -u 0.0001418938604954012 > ./result_10chains/node306_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_0 -p 724 -st none -pt topic306_7_0 -u 0.019200653488314484 > ./result_10chains/node306_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_8_0 -p 843 -st none -pt topic306_8_0 -u 0.017643862815796857 > ./result_10chains/node306_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_9_0 -p 908 -st none -pt topic306_9_0 -u 0.006042390047031859 > ./result_10chains/node306_9_0.txt &
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
    "./result_10chains/node306_0_0.txt 90"
    "./result_10chains/node306_0_2.txt 90"
    "./result_10chains/node306_1_0.txt 89"
    "./result_10chains/node306_1_2.txt 89"
    "./result_10chains/node306_2_0.txt 88"
    "./result_10chains/node306_2_2.txt 88"
    "./result_10chains/node306_3_0.txt 87"
    "./result_10chains/node306_3_2.txt 87"
    "./result_10chains/node306_4_0.txt 86"
    "./result_10chains/node306_4_2.txt 86"
    "./result_10chains/node306_5_0.txt 85"
    "./result_10chains/node306_5_2.txt 85"
    "./result_10chains/node306_6_0.txt 84"
    "./result_10chains/node306_6_2.txt 84"
    "./result_10chains/node306_7_0.txt 83"
    "./result_10chains/node306_7_2.txt 83"
    "./result_10chains/node306_8_0.txt 82"
    "./result_10chains/node306_8_2.txt 82"
    "./result_10chains/node306_9_0.txt 81"
    "./result_10chains/node306_9_2.txt 81"
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
