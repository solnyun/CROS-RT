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
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_1 -p 93 -st topic459_0_0 -pt topic459_0_1 -u 0.0002233706521451162 > ./result_8chains/node459_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_1 -p 232 -st topic459_1_0 -pt topic459_1_1 -u 0.020736364698853815 > ./result_8chains/node459_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_1 -p 263 -st topic459_2_0 -pt topic459_2_1 -u 0.07715045521459934 > ./result_8chains/node459_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_1 -p 292 -st topic459_3_0 -pt topic459_3_1 -u 0.0039001844847598166 > ./result_8chains/node459_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_1 -p 302 -st topic459_4_0 -pt topic459_4_1 -u 0.0018109353030734132 > ./result_8chains/node459_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_1 -p 337 -st topic459_5_0 -pt topic459_5_1 -u 0.0635453433750302 > ./result_8chains/node459_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_1 -p 604 -st topic459_6_0 -pt topic459_6_1 -u 0.011920318599322077 > ./result_8chains/node459_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_1 -p 796 -st topic459_7_0 -pt topic459_7_1 -u 0.03202831050033615 > ./result_8chains/node459_7_1.txt &
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
    "./result_8chains/node459_0_1.txt 90"
    "./result_8chains/node459_1_1.txt 89"
    "./result_8chains/node459_2_1.txt 88"
    "./result_8chains/node459_3_1.txt 87"
    "./result_8chains/node459_4_1.txt 86"
    "./result_8chains/node459_5_1.txt 85"
    "./result_8chains/node459_6_1.txt 84"
    "./result_8chains/node459_7_1.txt 83"
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
