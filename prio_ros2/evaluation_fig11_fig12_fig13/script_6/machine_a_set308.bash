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
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_2 -p 103 -st topic308_0_1 -pt None -u 0.016019433610526768 > ./result_6chains/node308_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_2 -p 210 -st topic308_1_1 -pt None -u 0.04089148582778118 > ./result_6chains/node308_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_2 -p 217 -st topic308_2_1 -pt None -u 0.07219442240592477 > ./result_6chains/node308_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_2 -p 508 -st topic308_3_1 -pt None -u 0.12388182025525163 > ./result_6chains/node308_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_2 -p 639 -st topic308_4_1 -pt None -u 0.017751786455383944 > ./result_6chains/node308_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_2 -p 698 -st topic308_5_1 -pt None -u 0.05487667329065597 > ./result_6chains/node308_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_0 -p 103 -st none -pt topic308_0_0 -u 0.002150159440291677 > ./result_6chains/node308_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_0 -p 210 -st none -pt topic308_1_0 -u 0.009257817135539137 > ./result_6chains/node308_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_0 -p 217 -st none -pt topic308_2_0 -u 0.03225605719451946 > ./result_6chains/node308_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_0 -p 508 -st none -pt topic308_3_0 -u 0.019377869082205124 > ./result_6chains/node308_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_0 -p 639 -st none -pt topic308_4_0 -u 0.012614419071721589 > ./result_6chains/node308_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_0 -p 698 -st none -pt topic308_5_0 -u 0.009920227685351071 > ./result_6chains/node308_5_0.txt &
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
    "./result_6chains/node308_0_0.txt 90"
    "./result_6chains/node308_0_2.txt 90"
    "./result_6chains/node308_1_0.txt 89"
    "./result_6chains/node308_1_2.txt 89"
    "./result_6chains/node308_2_0.txt 88"
    "./result_6chains/node308_2_2.txt 88"
    "./result_6chains/node308_3_0.txt 87"
    "./result_6chains/node308_3_2.txt 87"
    "./result_6chains/node308_4_0.txt 86"
    "./result_6chains/node308_4_2.txt 86"
    "./result_6chains/node308_5_0.txt 85"
    "./result_6chains/node308_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
