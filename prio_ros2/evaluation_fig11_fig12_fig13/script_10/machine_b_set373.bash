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
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_1 -p 29 -st topic373_0_0 -pt topic373_0_1 -u 0.0003778677511283579 > ./result_10chains/node373_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_1 -p 83 -st topic373_1_0 -pt topic373_1_1 -u 0.014916371476780321 > ./result_10chains/node373_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_1 -p 198 -st topic373_2_0 -pt topic373_2_1 -u 0.008246026414721497 > ./result_10chains/node373_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_1 -p 241 -st topic373_3_0 -pt topic373_3_1 -u 0.04093409052999769 > ./result_10chains/node373_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_1 -p 491 -st topic373_4_0 -pt topic373_4_1 -u 0.06721412624314371 > ./result_10chains/node373_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_1 -p 565 -st topic373_5_0 -pt topic373_5_1 -u 0.010639723085734992 > ./result_10chains/node373_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_1 -p 602 -st topic373_6_0 -pt topic373_6_1 -u 0.002293619765225824 > ./result_10chains/node373_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_1 -p 662 -st topic373_7_0 -pt topic373_7_1 -u 0.00525794168152989 > ./result_10chains/node373_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_8_1 -p 862 -st topic373_8_0 -pt topic373_8_1 -u 0.008757074977188209 > ./result_10chains/node373_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_9_1 -p 888 -st topic373_9_0 -pt topic373_9_1 -u 0.012489154767755303 > ./result_10chains/node373_9_1.txt &
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
    "./result_10chains/node373_0_1.txt 90"
    "./result_10chains/node373_1_1.txt 89"
    "./result_10chains/node373_2_1.txt 88"
    "./result_10chains/node373_3_1.txt 87"
    "./result_10chains/node373_4_1.txt 86"
    "./result_10chains/node373_5_1.txt 85"
    "./result_10chains/node373_6_1.txt 84"
    "./result_10chains/node373_7_1.txt 83"
    "./result_10chains/node373_8_1.txt 82"
    "./result_10chains/node373_9_1.txt 81"
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
