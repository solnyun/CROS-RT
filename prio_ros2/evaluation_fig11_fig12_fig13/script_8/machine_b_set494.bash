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
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_1 -p 168 -st topic494_0_0 -pt topic494_0_1 -u 0.03025474927090749 > ./result_8chains/node494_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_1 -p 281 -st topic494_1_0 -pt topic494_1_1 -u 0.0013232372995558572 > ./result_8chains/node494_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_1 -p 486 -st topic494_2_0 -pt topic494_2_1 -u 0.004094685361873629 > ./result_8chains/node494_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_1 -p 763 -st topic494_3_0 -pt topic494_3_1 -u 0.025602052480246718 > ./result_8chains/node494_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_1 -p 814 -st topic494_4_0 -pt topic494_4_1 -u 0.08992563505957404 > ./result_8chains/node494_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_1 -p 931 -st topic494_5_0 -pt topic494_5_1 -u 0.010570078091209523 > ./result_8chains/node494_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_6_1 -p 971 -st topic494_6_0 -pt topic494_6_1 -u 0.05198455790455328 > ./result_8chains/node494_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_7_1 -p 997 -st topic494_7_0 -pt topic494_7_1 -u 0.0014964479385741712 > ./result_8chains/node494_7_1.txt &
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
    "./result_8chains/node494_0_1.txt 90"
    "./result_8chains/node494_1_1.txt 89"
    "./result_8chains/node494_2_1.txt 88"
    "./result_8chains/node494_3_1.txt 87"
    "./result_8chains/node494_4_1.txt 86"
    "./result_8chains/node494_5_1.txt 85"
    "./result_8chains/node494_6_1.txt 84"
    "./result_8chains/node494_7_1.txt 83"
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
