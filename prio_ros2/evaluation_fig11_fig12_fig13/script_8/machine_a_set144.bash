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
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_2 -p 23 -st topic144_0_1 -pt None -u 0.016441313345104347 > ./result_8chains/node144_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_2 -p 114 -st topic144_1_1 -pt None -u 0.004231332658879483 > ./result_8chains/node144_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_2 -p 210 -st topic144_2_1 -pt None -u 0.005975984500837861 > ./result_8chains/node144_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_2 -p 225 -st topic144_3_1 -pt None -u 0.006336306275763703 > ./result_8chains/node144_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_2 -p 329 -st topic144_4_1 -pt None -u 0.022868939489066153 > ./result_8chains/node144_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_2 -p 395 -st topic144_5_1 -pt None -u 0.024987889951585934 > ./result_8chains/node144_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_2 -p 736 -st topic144_6_1 -pt None -u 0.0166420351966102 > ./result_8chains/node144_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_2 -p 894 -st topic144_7_1 -pt None -u 0.005180942351531463 > ./result_8chains/node144_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_0 -p 23 -st none -pt topic144_0_0 -u 0.05669675791305134 > ./result_8chains/node144_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_0 -p 114 -st none -pt topic144_1_0 -u 0.05111703336457113 > ./result_8chains/node144_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_0 -p 210 -st none -pt topic144_2_0 -u 0.0005120957007270222 > ./result_8chains/node144_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_0 -p 225 -st none -pt topic144_3_0 -u 0.018574580250815542 > ./result_8chains/node144_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_0 -p 329 -st none -pt topic144_4_0 -u 0.07204727250488094 > ./result_8chains/node144_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_0 -p 395 -st none -pt topic144_5_0 -u 0.009863571450368702 > ./result_8chains/node144_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_0 -p 736 -st none -pt topic144_6_0 -u 0.028438039697072898 > ./result_8chains/node144_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_0 -p 894 -st none -pt topic144_7_0 -u 0.052894575494036894 > ./result_8chains/node144_7_0.txt &
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
    "./result_8chains/node144_0_0.txt 90"
    "./result_8chains/node144_0_2.txt 90"
    "./result_8chains/node144_1_0.txt 89"
    "./result_8chains/node144_1_2.txt 89"
    "./result_8chains/node144_2_0.txt 88"
    "./result_8chains/node144_2_2.txt 88"
    "./result_8chains/node144_3_0.txt 87"
    "./result_8chains/node144_3_2.txt 87"
    "./result_8chains/node144_4_0.txt 86"
    "./result_8chains/node144_4_2.txt 86"
    "./result_8chains/node144_5_0.txt 85"
    "./result_8chains/node144_5_2.txt 85"
    "./result_8chains/node144_6_0.txt 84"
    "./result_8chains/node144_6_2.txt 84"
    "./result_8chains/node144_7_0.txt 83"
    "./result_8chains/node144_7_2.txt 83"
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
