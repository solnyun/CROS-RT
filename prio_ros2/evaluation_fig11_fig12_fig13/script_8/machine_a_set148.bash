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
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_2 -p 100 -st topic148_0_1 -pt None -u 0.0014113759800120085 > ./result_8chains/node148_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_2 -p 218 -st topic148_1_1 -pt None -u 0.06637782398890474 > ./result_8chains/node148_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_2 -p 423 -st topic148_2_1 -pt None -u 0.013218467913876208 > ./result_8chains/node148_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_2 -p 589 -st topic148_3_1 -pt None -u 0.005566945505801391 > ./result_8chains/node148_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_2 -p 647 -st topic148_4_1 -pt None -u 0.004470904887096422 > ./result_8chains/node148_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_2 -p 707 -st topic148_5_1 -pt None -u 0.0020237996740046504 > ./result_8chains/node148_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_2 -p 714 -st topic148_6_1 -pt None -u 0.01786174276434209 > ./result_8chains/node148_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_2 -p 974 -st topic148_7_1 -pt None -u 0.003943730858403639 > ./result_8chains/node148_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_0 -p 100 -st none -pt topic148_0_0 -u 0.001305915076687314 > ./result_8chains/node148_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_0 -p 218 -st none -pt topic148_1_0 -u 0.05598168529823755 > ./result_8chains/node148_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_0 -p 423 -st none -pt topic148_2_0 -u 0.018411468366275996 > ./result_8chains/node148_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_0 -p 589 -st none -pt topic148_3_0 -u 0.008954786938558501 > ./result_8chains/node148_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_0 -p 647 -st none -pt topic148_4_0 -u 0.007841351754438924 > ./result_8chains/node148_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_0 -p 707 -st none -pt topic148_5_0 -u 0.003632882754845218 > ./result_8chains/node148_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_0 -p 714 -st none -pt topic148_6_0 -u 0.053908321075092996 > ./result_8chains/node148_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_0 -p 974 -st none -pt topic148_7_0 -u 0.01346096585203968 > ./result_8chains/node148_7_0.txt &
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
    "./result_8chains/node148_0_0.txt 90"
    "./result_8chains/node148_0_2.txt 90"
    "./result_8chains/node148_1_0.txt 89"
    "./result_8chains/node148_1_2.txt 89"
    "./result_8chains/node148_2_0.txt 88"
    "./result_8chains/node148_2_2.txt 88"
    "./result_8chains/node148_3_0.txt 87"
    "./result_8chains/node148_3_2.txt 87"
    "./result_8chains/node148_4_0.txt 86"
    "./result_8chains/node148_4_2.txt 86"
    "./result_8chains/node148_5_0.txt 85"
    "./result_8chains/node148_5_2.txt 85"
    "./result_8chains/node148_6_0.txt 84"
    "./result_8chains/node148_6_2.txt 84"
    "./result_8chains/node148_7_0.txt 83"
    "./result_8chains/node148_7_2.txt 83"
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
