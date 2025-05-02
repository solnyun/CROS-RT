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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_2 -p 299 -st topic197_0_1 -pt None -u 0.11290114233115095 > ./result_6chains/node197_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_2 -p 445 -st topic197_1_1 -pt None -u 0.03378149003481273 > ./result_6chains/node197_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_2 -p 506 -st topic197_2_1 -pt None -u 0.0069811892577375245 > ./result_6chains/node197_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_2 -p 785 -st topic197_3_1 -pt None -u 0.0017694361214854182 > ./result_6chains/node197_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_2 -p 795 -st topic197_4_1 -pt None -u 0.030954793387070946 > ./result_6chains/node197_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_2 -p 843 -st topic197_5_1 -pt None -u 0.007068681603518917 > ./result_6chains/node197_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_0 -p 299 -st none -pt topic197_0_0 -u 0.021064050065987938 > ./result_6chains/node197_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_0 -p 445 -st none -pt topic197_1_0 -u 0.0031561045032619806 > ./result_6chains/node197_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_0 -p 506 -st none -pt topic197_2_0 -u 0.03102867636082518 > ./result_6chains/node197_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_0 -p 785 -st none -pt topic197_3_0 -u 0.043293470507511034 > ./result_6chains/node197_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_0 -p 795 -st none -pt topic197_4_0 -u 0.05576982494864205 > ./result_6chains/node197_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_0 -p 843 -st none -pt topic197_5_0 -u 0.019783258374693538 > ./result_6chains/node197_5_0.txt &
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
    "./result_6chains/node197_0_0.txt 90"
    "./result_6chains/node197_0_2.txt 90"
    "./result_6chains/node197_1_0.txt 89"
    "./result_6chains/node197_1_2.txt 89"
    "./result_6chains/node197_2_0.txt 88"
    "./result_6chains/node197_2_2.txt 88"
    "./result_6chains/node197_3_0.txt 87"
    "./result_6chains/node197_3_2.txt 87"
    "./result_6chains/node197_4_0.txt 86"
    "./result_6chains/node197_4_2.txt 86"
    "./result_6chains/node197_5_0.txt 85"
    "./result_6chains/node197_5_2.txt 85"
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
