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
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_1 -p 181 -st topic405_0_0 -pt topic405_0_1 -u 0.003394179078239412 > ./result_10chains/node405_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_1 -p 311 -st topic405_1_0 -pt topic405_1_1 -u 0.03373260905967729 > ./result_10chains/node405_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_1 -p 354 -st topic405_2_0 -pt topic405_2_1 -u 0.029203936409094633 > ./result_10chains/node405_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_1 -p 405 -st topic405_3_0 -pt topic405_3_1 -u 0.03408365520254891 > ./result_10chains/node405_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_1 -p 513 -st topic405_4_0 -pt topic405_4_1 -u 0.010659276032282783 > ./result_10chains/node405_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_1 -p 560 -st topic405_5_0 -pt topic405_5_1 -u 0.01802716091636125 > ./result_10chains/node405_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_6_1 -p 677 -st topic405_6_0 -pt topic405_6_1 -u 0.011078507904306839 > ./result_10chains/node405_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_7_1 -p 802 -st topic405_7_0 -pt topic405_7_1 -u 0.011002721801987539 > ./result_10chains/node405_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_8_1 -p 843 -st topic405_8_0 -pt topic405_8_1 -u 0.0007583099713203006 > ./result_10chains/node405_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_9_1 -p 884 -st topic405_9_0 -pt topic405_9_1 -u 0.0007079917017788406 > ./result_10chains/node405_9_1.txt &
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
    "./result_10chains/node405_0_1.txt 90"
    "./result_10chains/node405_1_1.txt 89"
    "./result_10chains/node405_2_1.txt 88"
    "./result_10chains/node405_3_1.txt 87"
    "./result_10chains/node405_4_1.txt 86"
    "./result_10chains/node405_5_1.txt 85"
    "./result_10chains/node405_6_1.txt 84"
    "./result_10chains/node405_7_1.txt 83"
    "./result_10chains/node405_8_1.txt 82"
    "./result_10chains/node405_9_1.txt 81"
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
