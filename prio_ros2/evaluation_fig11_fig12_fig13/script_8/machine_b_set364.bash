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
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_1 -p 112 -st topic364_0_0 -pt topic364_0_1 -u 0.03304144918083085 > ./result_8chains/node364_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_1 -p 130 -st topic364_1_0 -pt topic364_1_1 -u 0.005628310305746509 > ./result_8chains/node364_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_1 -p 189 -st topic364_2_0 -pt topic364_2_1 -u 0.0191178798136164 > ./result_8chains/node364_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_1 -p 490 -st topic364_3_0 -pt topic364_3_1 -u 0.047329447100534106 > ./result_8chains/node364_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_1 -p 611 -st topic364_4_0 -pt topic364_4_1 -u 0.006068306886176211 > ./result_8chains/node364_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_1 -p 797 -st topic364_5_0 -pt topic364_5_1 -u 0.02240192099259347 > ./result_8chains/node364_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_1 -p 920 -st topic364_6_0 -pt topic364_6_1 -u 0.023519789834087312 > ./result_8chains/node364_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_1 -p 938 -st topic364_7_0 -pt topic364_7_1 -u 0.013640244753947022 > ./result_8chains/node364_7_1.txt &
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
    "./result_8chains/node364_0_1.txt 90"
    "./result_8chains/node364_1_1.txt 89"
    "./result_8chains/node364_2_1.txt 88"
    "./result_8chains/node364_3_1.txt 87"
    "./result_8chains/node364_4_1.txt 86"
    "./result_8chains/node364_5_1.txt 85"
    "./result_8chains/node364_6_1.txt 84"
    "./result_8chains/node364_7_1.txt 83"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
