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
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_2 -p 302 -st topic318_0_1 -pt None -u 0.003860182477702756 > ./result_8chains/node318_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_2 -p 374 -st topic318_1_1 -pt None -u 0.06728616584206992 > ./result_8chains/node318_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_2 -p 659 -st topic318_2_1 -pt None -u 0.01322793963183666 > ./result_8chains/node318_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_2 -p 678 -st topic318_3_1 -pt None -u 0.015368083881061645 > ./result_8chains/node318_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_2 -p 752 -st topic318_4_1 -pt None -u 0.001231684988253906 > ./result_8chains/node318_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_2 -p 788 -st topic318_5_1 -pt None -u 0.008802889496362848 > ./result_8chains/node318_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_6_2 -p 879 -st topic318_6_1 -pt None -u 0.023287717934280153 > ./result_8chains/node318_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_7_2 -p 998 -st topic318_7_1 -pt None -u 0.0007273451045281339 > ./result_8chains/node318_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_0 -p 302 -st none -pt topic318_0_0 -u 0.01886514481933338 > ./result_8chains/node318_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_0 -p 374 -st none -pt topic318_1_0 -u 0.019028293665876994 > ./result_8chains/node318_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_0 -p 659 -st none -pt topic318_2_0 -u 0.047345099198141394 > ./result_8chains/node318_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_0 -p 678 -st none -pt topic318_3_0 -u 0.006458552281373098 > ./result_8chains/node318_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_0 -p 752 -st none -pt topic318_4_0 -u 0.011537122886849827 > ./result_8chains/node318_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_0 -p 788 -st none -pt topic318_5_0 -u 0.0010525148347045321 > ./result_8chains/node318_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_6_0 -p 879 -st none -pt topic318_6_0 -u 0.05625258081236201 > ./result_8chains/node318_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_7_0 -p 998 -st none -pt topic318_7_0 -u 0.018416590367883512 > ./result_8chains/node318_7_0.txt &
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
    "./result_8chains/node318_0_0.txt 90"
    "./result_8chains/node318_0_2.txt 90"
    "./result_8chains/node318_1_0.txt 89"
    "./result_8chains/node318_1_2.txt 89"
    "./result_8chains/node318_2_0.txt 88"
    "./result_8chains/node318_2_2.txt 88"
    "./result_8chains/node318_3_0.txt 87"
    "./result_8chains/node318_3_2.txt 87"
    "./result_8chains/node318_4_0.txt 86"
    "./result_8chains/node318_4_2.txt 86"
    "./result_8chains/node318_5_0.txt 85"
    "./result_8chains/node318_5_2.txt 85"
    "./result_8chains/node318_6_0.txt 84"
    "./result_8chains/node318_6_2.txt 84"
    "./result_8chains/node318_7_0.txt 83"
    "./result_8chains/node318_7_2.txt 83"
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
