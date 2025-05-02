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
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_2 -p 60 -st topic421_0_1 -pt None -u 0.008094978303069322 > ./result_8chains/node421_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_2 -p 210 -st topic421_1_1 -pt None -u 0.016548939615875446 > ./result_8chains/node421_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_2 -p 294 -st topic421_2_1 -pt None -u 0.015650286995027407 > ./result_8chains/node421_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_2 -p 326 -st topic421_3_1 -pt None -u 0.013248284408157784 > ./result_8chains/node421_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_4_2 -p 408 -st topic421_4_1 -pt None -u 0.010039336311376018 > ./result_8chains/node421_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_5_2 -p 530 -st topic421_5_1 -pt None -u 0.0033110425299115454 > ./result_8chains/node421_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_6_2 -p 556 -st topic421_6_1 -pt None -u 0.020605353514687827 > ./result_8chains/node421_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_7_2 -p 880 -st topic421_7_1 -pt None -u 0.013947415543050764 > ./result_8chains/node421_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_0 -p 60 -st none -pt topic421_0_0 -u 0.012632443231755774 > ./result_8chains/node421_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_0 -p 210 -st none -pt topic421_1_0 -u 0.005400283522048577 > ./result_8chains/node421_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_0 -p 294 -st none -pt topic421_2_0 -u 0.002705532629772245 > ./result_8chains/node421_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_0 -p 326 -st none -pt topic421_3_0 -u 0.008736139017281763 > ./result_8chains/node421_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_4_0 -p 408 -st none -pt topic421_4_0 -u 0.036927556046083526 > ./result_8chains/node421_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_5_0 -p 530 -st none -pt topic421_5_0 -u 0.0031933664127538064 > ./result_8chains/node421_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_6_0 -p 556 -st none -pt topic421_6_0 -u 0.03428770374086104 > ./result_8chains/node421_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_7_0 -p 880 -st none -pt topic421_7_0 -u 0.06756923567315447 > ./result_8chains/node421_7_0.txt &
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
    "./result_8chains/node421_0_0.txt 90"
    "./result_8chains/node421_0_2.txt 90"
    "./result_8chains/node421_1_0.txt 89"
    "./result_8chains/node421_1_2.txt 89"
    "./result_8chains/node421_2_0.txt 88"
    "./result_8chains/node421_2_2.txt 88"
    "./result_8chains/node421_3_0.txt 87"
    "./result_8chains/node421_3_2.txt 87"
    "./result_8chains/node421_4_0.txt 86"
    "./result_8chains/node421_4_2.txt 86"
    "./result_8chains/node421_5_0.txt 85"
    "./result_8chains/node421_5_2.txt 85"
    "./result_8chains/node421_6_0.txt 84"
    "./result_8chains/node421_6_2.txt 84"
    "./result_8chains/node421_7_0.txt 83"
    "./result_8chains/node421_7_2.txt 83"
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
