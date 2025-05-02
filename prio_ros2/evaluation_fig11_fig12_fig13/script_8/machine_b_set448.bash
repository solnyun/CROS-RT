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
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_1 -p 29 -st topic448_0_0 -pt topic448_0_1 -u 0.0023485658648910723 > ./result_8chains/node448_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_1 -p 107 -st topic448_1_0 -pt topic448_1_1 -u 0.04113357709829285 > ./result_8chains/node448_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_1 -p 125 -st topic448_2_0 -pt topic448_2_1 -u 0.026696655624532106 > ./result_8chains/node448_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_1 -p 306 -st topic448_3_0 -pt topic448_3_1 -u 0.030386172774761466 > ./result_8chains/node448_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_1 -p 693 -st topic448_4_0 -pt topic448_4_1 -u 0.002841005670738833 > ./result_8chains/node448_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_1 -p 785 -st topic448_5_0 -pt topic448_5_1 -u 0.0067014177027667765 > ./result_8chains/node448_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_1 -p 885 -st topic448_6_0 -pt topic448_6_1 -u 0.040652130507776454 > ./result_8chains/node448_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_1 -p 935 -st topic448_7_0 -pt topic448_7_1 -u 0.03751834086186153 > ./result_8chains/node448_7_1.txt &
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
    "./result_8chains/node448_0_1.txt 90"
    "./result_8chains/node448_1_1.txt 89"
    "./result_8chains/node448_2_1.txt 88"
    "./result_8chains/node448_3_1.txt 87"
    "./result_8chains/node448_4_1.txt 86"
    "./result_8chains/node448_5_1.txt 85"
    "./result_8chains/node448_6_1.txt 84"
    "./result_8chains/node448_7_1.txt 83"
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
