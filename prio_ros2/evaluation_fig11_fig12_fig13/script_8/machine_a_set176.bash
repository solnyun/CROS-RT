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
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_2 -p 56 -st topic176_0_1 -pt None -u 0.01975362901327654 > ./result_8chains/node176_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_2 -p 96 -st topic176_1_1 -pt None -u 0.007505278120454428 > ./result_8chains/node176_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_2 -p 449 -st topic176_2_1 -pt None -u 0.054255779060757126 > ./result_8chains/node176_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_2 -p 494 -st topic176_3_1 -pt None -u 0.010352434063250288 > ./result_8chains/node176_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_2 -p 562 -st topic176_4_1 -pt None -u 0.021931810264795487 > ./result_8chains/node176_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_2 -p 697 -st topic176_5_1 -pt None -u 0.0012449892508688831 > ./result_8chains/node176_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_2 -p 798 -st topic176_6_1 -pt None -u 0.004726581482909109 > ./result_8chains/node176_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_2 -p 825 -st topic176_7_1 -pt None -u 0.018033333909822567 > ./result_8chains/node176_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_0_0 -p 56 -st none -pt topic176_0_0 -u 0.002909176298537597 > ./result_8chains/node176_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_1_0 -p 96 -st none -pt topic176_1_0 -u 0.0036859482325846127 > ./result_8chains/node176_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_2_0 -p 449 -st none -pt topic176_2_0 -u 0.0002594882496650963 > ./result_8chains/node176_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_3_0 -p 494 -st none -pt topic176_3_0 -u 0.05492349583316239 > ./result_8chains/node176_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_4_0 -p 562 -st none -pt topic176_4_0 -u 0.01915041154920949 > ./result_8chains/node176_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_5_0 -p 697 -st none -pt topic176_5_0 -u 0.046998244526540375 > ./result_8chains/node176_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node176_6_0 -p 798 -st none -pt topic176_6_0 -u 0.0003160666621991326 > ./result_8chains/node176_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node176_7_0 -p 825 -st none -pt topic176_7_0 -u 0.0029053805233613395 > ./result_8chains/node176_7_0.txt &
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
    "./result_8chains/node176_0_0.txt 90"
    "./result_8chains/node176_0_2.txt 90"
    "./result_8chains/node176_1_0.txt 89"
    "./result_8chains/node176_1_2.txt 89"
    "./result_8chains/node176_2_0.txt 88"
    "./result_8chains/node176_2_2.txt 88"
    "./result_8chains/node176_3_0.txt 87"
    "./result_8chains/node176_3_2.txt 87"
    "./result_8chains/node176_4_0.txt 86"
    "./result_8chains/node176_4_2.txt 86"
    "./result_8chains/node176_5_0.txt 85"
    "./result_8chains/node176_5_2.txt 85"
    "./result_8chains/node176_6_0.txt 84"
    "./result_8chains/node176_6_2.txt 84"
    "./result_8chains/node176_7_0.txt 83"
    "./result_8chains/node176_7_2.txt 83"
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
