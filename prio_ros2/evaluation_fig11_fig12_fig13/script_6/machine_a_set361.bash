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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_2 -p 173 -st topic361_0_1 -pt None -u 0.013483902298237094 > ./result_6chains/node361_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_2 -p 331 -st topic361_1_1 -pt None -u 0.030726889223460396 > ./result_6chains/node361_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_2 -p 610 -st topic361_2_1 -pt None -u 0.016646439157019244 > ./result_6chains/node361_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_2 -p 681 -st topic361_3_1 -pt None -u 0.04141553374340695 > ./result_6chains/node361_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_2 -p 754 -st topic361_4_1 -pt None -u 0.053317242423924716 > ./result_6chains/node361_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_2 -p 895 -st topic361_5_1 -pt None -u 0.06105079373991673 > ./result_6chains/node361_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_0 -p 173 -st none -pt topic361_0_0 -u 0.013433683583552514 > ./result_6chains/node361_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_0 -p 331 -st none -pt topic361_1_0 -u 0.021931296574408843 > ./result_6chains/node361_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_0 -p 610 -st none -pt topic361_2_0 -u 0.014748262608877127 > ./result_6chains/node361_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_0 -p 681 -st none -pt topic361_3_0 -u 0.008111100334956878 > ./result_6chains/node361_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_0 -p 754 -st none -pt topic361_4_0 -u 0.02179821115921768 > ./result_6chains/node361_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_0 -p 895 -st none -pt topic361_5_0 -u 0.05009823344824772 > ./result_6chains/node361_5_0.txt &
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
    "./result_6chains/node361_0_0.txt 90"
    "./result_6chains/node361_0_2.txt 90"
    "./result_6chains/node361_1_0.txt 89"
    "./result_6chains/node361_1_2.txt 89"
    "./result_6chains/node361_2_0.txt 88"
    "./result_6chains/node361_2_2.txt 88"
    "./result_6chains/node361_3_0.txt 87"
    "./result_6chains/node361_3_2.txt 87"
    "./result_6chains/node361_4_0.txt 86"
    "./result_6chains/node361_4_2.txt 86"
    "./result_6chains/node361_5_0.txt 85"
    "./result_6chains/node361_5_2.txt 85"
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
