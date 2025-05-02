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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_1 -p 23 -st topic361_0_0 -pt topic361_0_1 -u 0.011677634095896006 > ./result_8chains/node361_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_1 -p 26 -st topic361_1_0 -pt topic361_1_1 -u 0.03116741522070071 > ./result_8chains/node361_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_1 -p 36 -st topic361_2_0 -pt topic361_2_1 -u 0.05212518615336792 > ./result_8chains/node361_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_1 -p 299 -st topic361_3_0 -pt topic361_3_1 -u 0.019395874716786915 > ./result_8chains/node361_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_1 -p 515 -st topic361_4_0 -pt topic361_4_1 -u 0.030896522702950818 > ./result_8chains/node361_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_1 -p 770 -st topic361_5_0 -pt topic361_5_1 -u 0.00545288458601173 > ./result_8chains/node361_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_1 -p 907 -st topic361_6_0 -pt topic361_6_1 -u 0.009829204298461222 > ./result_8chains/node361_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_1 -p 959 -st topic361_7_0 -pt topic361_7_1 -u 0.0043651863588333875 > ./result_8chains/node361_7_1.txt &
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
    "./result_8chains/node361_0_1.txt 90"
    "./result_8chains/node361_1_1.txt 89"
    "./result_8chains/node361_2_1.txt 88"
    "./result_8chains/node361_3_1.txt 87"
    "./result_8chains/node361_4_1.txt 86"
    "./result_8chains/node361_5_1.txt 85"
    "./result_8chains/node361_6_1.txt 84"
    "./result_8chains/node361_7_1.txt 83"
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
