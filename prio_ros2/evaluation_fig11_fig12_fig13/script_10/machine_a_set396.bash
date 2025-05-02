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
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_2 -p 47 -st topic396_0_1 -pt None -u 0.007982162233406254 > ./result_10chains/node396_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_2 -p 56 -st topic396_1_1 -pt None -u 0.0005519401163592841 > ./result_10chains/node396_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_2 -p 337 -st topic396_2_1 -pt None -u 0.043945745146563686 > ./result_10chains/node396_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_2 -p 381 -st topic396_3_1 -pt None -u 0.0157615341717387 > ./result_10chains/node396_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_2 -p 403 -st topic396_4_1 -pt None -u 0.0015272994179469923 > ./result_10chains/node396_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_2 -p 580 -st topic396_5_1 -pt None -u 0.02058475734795498 > ./result_10chains/node396_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_6_2 -p 743 -st topic396_6_1 -pt None -u 0.03738061866040067 > ./result_10chains/node396_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_7_2 -p 777 -st topic396_7_1 -pt None -u 0.020010178126587147 > ./result_10chains/node396_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_8_2 -p 987 -st topic396_8_1 -pt None -u 0.015725834614610093 > ./result_10chains/node396_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_9_2 -p 993 -st topic396_9_1 -pt None -u 0.006255741350444225 > ./result_10chains/node396_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_0 -p 47 -st none -pt topic396_0_0 -u 0.012494830425220538 > ./result_10chains/node396_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_0 -p 56 -st none -pt topic396_1_0 -u 0.018750257752586652 > ./result_10chains/node396_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_0 -p 337 -st none -pt topic396_2_0 -u 0.04165856970231535 > ./result_10chains/node396_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_0 -p 381 -st none -pt topic396_3_0 -u 0.0205720357865411 > ./result_10chains/node396_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_0 -p 403 -st none -pt topic396_4_0 -u 0.011879588961273835 > ./result_10chains/node396_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_0 -p 580 -st none -pt topic396_5_0 -u 0.05661553636009517 > ./result_10chains/node396_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_6_0 -p 743 -st none -pt topic396_6_0 -u 0.0017486367795366276 > ./result_10chains/node396_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_7_0 -p 777 -st none -pt topic396_7_0 -u 0.021379283652969136 > ./result_10chains/node396_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_8_0 -p 987 -st none -pt topic396_8_0 -u 0.02283026016663181 > ./result_10chains/node396_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_9_0 -p 993 -st none -pt topic396_9_0 -u 0.0031882428583373743 > ./result_10chains/node396_9_0.txt &
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
    "./result_10chains/node396_0_0.txt 90"
    "./result_10chains/node396_0_2.txt 90"
    "./result_10chains/node396_1_0.txt 89"
    "./result_10chains/node396_1_2.txt 89"
    "./result_10chains/node396_2_0.txt 88"
    "./result_10chains/node396_2_2.txt 88"
    "./result_10chains/node396_3_0.txt 87"
    "./result_10chains/node396_3_2.txt 87"
    "./result_10chains/node396_4_0.txt 86"
    "./result_10chains/node396_4_2.txt 86"
    "./result_10chains/node396_5_0.txt 85"
    "./result_10chains/node396_5_2.txt 85"
    "./result_10chains/node396_6_0.txt 84"
    "./result_10chains/node396_6_2.txt 84"
    "./result_10chains/node396_7_0.txt 83"
    "./result_10chains/node396_7_2.txt 83"
    "./result_10chains/node396_8_0.txt 82"
    "./result_10chains/node396_8_2.txt 82"
    "./result_10chains/node396_9_0.txt 81"
    "./result_10chains/node396_9_2.txt 81"
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
