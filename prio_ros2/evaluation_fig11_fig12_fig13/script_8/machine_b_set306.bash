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
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_1 -p 109 -st topic306_0_0 -pt topic306_0_1 -u 0.07575776310674726 > ./result_8chains/node306_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_1 -p 314 -st topic306_1_0 -pt topic306_1_1 -u 0.010619197322196294 > ./result_8chains/node306_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_1 -p 348 -st topic306_2_0 -pt topic306_2_1 -u 0.0029689722819803976 > ./result_8chains/node306_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_1 -p 513 -st topic306_3_0 -pt topic306_3_1 -u 9.728435443739913e-05 > ./result_8chains/node306_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_1 -p 650 -st topic306_4_0 -pt topic306_4_1 -u 0.07011489189364262 > ./result_8chains/node306_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_1 -p 749 -st topic306_5_0 -pt topic306_5_1 -u 0.02805983491017333 > ./result_8chains/node306_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_1 -p 802 -st topic306_6_0 -pt topic306_6_1 -u 0.00039266705138840674 > ./result_8chains/node306_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_1 -p 976 -st topic306_7_0 -pt topic306_7_1 -u 0.0012342419052370534 > ./result_8chains/node306_7_1.txt &
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
    "./result_8chains/node306_0_1.txt 90"
    "./result_8chains/node306_1_1.txt 89"
    "./result_8chains/node306_2_1.txt 88"
    "./result_8chains/node306_3_1.txt 87"
    "./result_8chains/node306_4_1.txt 86"
    "./result_8chains/node306_5_1.txt 85"
    "./result_8chains/node306_6_1.txt 84"
    "./result_8chains/node306_7_1.txt 83"
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
