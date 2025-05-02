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
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_2 -p 94 -st topic230_0_1 -pt None -u 0.017624324832728078 > ./result_8chains/node230_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_2 -p 130 -st topic230_1_1 -pt None -u 0.018130431619250764 > ./result_8chains/node230_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_2 -p 492 -st topic230_2_1 -pt None -u 0.0016430475122891641 > ./result_8chains/node230_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_2 -p 535 -st topic230_3_1 -pt None -u 0.03937893132308462 > ./result_8chains/node230_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_2 -p 640 -st topic230_4_1 -pt None -u 0.05916599490654531 > ./result_8chains/node230_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_2 -p 734 -st topic230_5_1 -pt None -u 0.006877265967420859 > ./result_8chains/node230_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_6_2 -p 818 -st topic230_6_1 -pt None -u 0.04516794273715252 > ./result_8chains/node230_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_7_2 -p 826 -st topic230_7_1 -pt None -u 0.0007828980714675756 > ./result_8chains/node230_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_0 -p 94 -st none -pt topic230_0_0 -u 0.022317565153120333 > ./result_8chains/node230_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_0 -p 130 -st none -pt topic230_1_0 -u 0.00010830612749923585 > ./result_8chains/node230_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_0 -p 492 -st none -pt topic230_2_0 -u 0.0539755788806503 > ./result_8chains/node230_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_0 -p 535 -st none -pt topic230_3_0 -u 0.00010795914999750522 > ./result_8chains/node230_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_0 -p 640 -st none -pt topic230_4_0 -u 0.00882148846885733 > ./result_8chains/node230_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_0 -p 734 -st none -pt topic230_5_0 -u 0.0011463380966680037 > ./result_8chains/node230_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_6_0 -p 818 -st none -pt topic230_6_0 -u 0.06926915186701134 > ./result_8chains/node230_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_7_0 -p 826 -st none -pt topic230_7_0 -u 0.036431383854612545 > ./result_8chains/node230_7_0.txt &
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
    "./result_8chains/node230_0_0.txt 90"
    "./result_8chains/node230_0_2.txt 90"
    "./result_8chains/node230_1_0.txt 89"
    "./result_8chains/node230_1_2.txt 89"
    "./result_8chains/node230_2_0.txt 88"
    "./result_8chains/node230_2_2.txt 88"
    "./result_8chains/node230_3_0.txt 87"
    "./result_8chains/node230_3_2.txt 87"
    "./result_8chains/node230_4_0.txt 86"
    "./result_8chains/node230_4_2.txt 86"
    "./result_8chains/node230_5_0.txt 85"
    "./result_8chains/node230_5_2.txt 85"
    "./result_8chains/node230_6_0.txt 84"
    "./result_8chains/node230_6_2.txt 84"
    "./result_8chains/node230_7_0.txt 83"
    "./result_8chains/node230_7_2.txt 83"
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
