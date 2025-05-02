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
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_1 -p 139 -st topic472_0_0 -pt topic472_0_1 -u 0.03456796477525248 > ./result_8chains/node472_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_1 -p 308 -st topic472_1_0 -pt topic472_1_1 -u 0.003557179978575964 > ./result_8chains/node472_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_1 -p 512 -st topic472_2_0 -pt topic472_2_1 -u 0.002679494053553444 > ./result_8chains/node472_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_1 -p 618 -st topic472_3_0 -pt topic472_3_1 -u 0.004581918519581674 > ./result_8chains/node472_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_1 -p 750 -st topic472_4_0 -pt topic472_4_1 -u 0.09741852004411147 > ./result_8chains/node472_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_1 -p 871 -st topic472_5_0 -pt topic472_5_1 -u 0.07075170297727126 > ./result_8chains/node472_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_6_1 -p 912 -st topic472_6_0 -pt topic472_6_1 -u 0.0031859985298736127 > ./result_8chains/node472_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_7_1 -p 994 -st topic472_7_0 -pt topic472_7_1 -u 0.003285947484703129 > ./result_8chains/node472_7_1.txt &
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
    "./result_8chains/node472_0_1.txt 90"
    "./result_8chains/node472_1_1.txt 89"
    "./result_8chains/node472_2_1.txt 88"
    "./result_8chains/node472_3_1.txt 87"
    "./result_8chains/node472_4_1.txt 86"
    "./result_8chains/node472_5_1.txt 85"
    "./result_8chains/node472_6_1.txt 84"
    "./result_8chains/node472_7_1.txt 83"
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
