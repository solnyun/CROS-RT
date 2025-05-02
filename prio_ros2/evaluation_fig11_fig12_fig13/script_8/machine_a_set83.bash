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
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_2 -p 13 -st topic83_0_1 -pt None -u 0.03545002875785086 > ./result_8chains/node83_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_2 -p 242 -st topic83_1_1 -pt None -u 0.0018598625982025885 > ./result_8chains/node83_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_2 -p 415 -st topic83_2_1 -pt None -u 0.0609446540564782 > ./result_8chains/node83_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_2 -p 466 -st topic83_3_1 -pt None -u 0.008012377555290662 > ./result_8chains/node83_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_2 -p 471 -st topic83_4_1 -pt None -u 0.02687220976380894 > ./result_8chains/node83_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_2 -p 529 -st topic83_5_1 -pt None -u 0.0020354238197651114 > ./result_8chains/node83_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_2 -p 826 -st topic83_6_1 -pt None -u 0.0004569393168067648 > ./result_8chains/node83_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_2 -p 875 -st topic83_7_1 -pt None -u 0.027062885269261445 > ./result_8chains/node83_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_0 -p 13 -st none -pt topic83_0_0 -u 0.00951424057291872 > ./result_8chains/node83_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_0 -p 242 -st none -pt topic83_1_0 -u 0.0010574770957496038 > ./result_8chains/node83_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_0 -p 415 -st none -pt topic83_2_0 -u 0.0038456022144386925 > ./result_8chains/node83_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_0 -p 466 -st none -pt topic83_3_0 -u 0.0477088405532618 > ./result_8chains/node83_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_0 -p 471 -st none -pt topic83_4_0 -u 0.06105011642516964 > ./result_8chains/node83_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_0 -p 529 -st none -pt topic83_5_0 -u 0.020710176637601385 > ./result_8chains/node83_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_0 -p 826 -st none -pt topic83_6_0 -u 0.0030742231324263625 > ./result_8chains/node83_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_0 -p 875 -st none -pt topic83_7_0 -u 0.02084325063648325 > ./result_8chains/node83_7_0.txt &
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
    "./result_8chains/node83_0_0.txt 90"
    "./result_8chains/node83_0_2.txt 90"
    "./result_8chains/node83_1_0.txt 89"
    "./result_8chains/node83_1_2.txt 89"
    "./result_8chains/node83_2_0.txt 88"
    "./result_8chains/node83_2_2.txt 88"
    "./result_8chains/node83_3_0.txt 87"
    "./result_8chains/node83_3_2.txt 87"
    "./result_8chains/node83_4_0.txt 86"
    "./result_8chains/node83_4_2.txt 86"
    "./result_8chains/node83_5_0.txt 85"
    "./result_8chains/node83_5_2.txt 85"
    "./result_8chains/node83_6_0.txt 84"
    "./result_8chains/node83_6_2.txt 84"
    "./result_8chains/node83_7_0.txt 83"
    "./result_8chains/node83_7_2.txt 83"
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
