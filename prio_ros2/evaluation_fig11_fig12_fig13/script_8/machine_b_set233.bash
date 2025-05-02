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
ros2 run evaluation_3_randomdag uunifast_node -n node233_0_1 -p 66 -st topic233_0_0 -pt topic233_0_1 -u 0.0680517833702588 > ./result_8chains/node233_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_1_1 -p 227 -st topic233_1_0 -pt topic233_1_1 -u 0.003190657800994867 > ./result_8chains/node233_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_2_1 -p 296 -st topic233_2_0 -pt topic233_2_1 -u 0.022475164871575748 > ./result_8chains/node233_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_3_1 -p 710 -st topic233_3_0 -pt topic233_3_1 -u 0.013573597339082033 > ./result_8chains/node233_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_4_1 -p 760 -st topic233_4_0 -pt topic233_4_1 -u 0.0027310252253101575 > ./result_8chains/node233_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_5_1 -p 799 -st topic233_5_0 -pt topic233_5_1 -u 0.03192397829644883 > ./result_8chains/node233_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_6_1 -p 801 -st topic233_6_0 -pt topic233_6_1 -u 0.06902383056961274 > ./result_8chains/node233_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node233_7_1 -p 906 -st topic233_7_0 -pt topic233_7_1 -u 0.013770418968150473 > ./result_8chains/node233_7_1.txt &
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
    "./result_8chains/node233_0_1.txt 90"
    "./result_8chains/node233_1_1.txt 89"
    "./result_8chains/node233_2_1.txt 88"
    "./result_8chains/node233_3_1.txt 87"
    "./result_8chains/node233_4_1.txt 86"
    "./result_8chains/node233_5_1.txt 85"
    "./result_8chains/node233_6_1.txt 84"
    "./result_8chains/node233_7_1.txt 83"
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
