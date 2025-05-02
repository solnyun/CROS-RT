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
ros2 run evaluation_3_randomdag uunifast_node -n node157_0_1 -p 189 -st topic157_0_0 -pt topic157_0_1 -u 0.0012264947358732181 > ./result_8chains/node157_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_1_1 -p 313 -st topic157_1_0 -pt topic157_1_1 -u 0.0010177857072983798 > ./result_8chains/node157_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_2_1 -p 451 -st topic157_2_0 -pt topic157_2_1 -u 0.033167151237491255 > ./result_8chains/node157_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_3_1 -p 627 -st topic157_3_0 -pt topic157_3_1 -u 0.0038892739925693864 > ./result_8chains/node157_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_4_1 -p 636 -st topic157_4_0 -pt topic157_4_1 -u 0.011774515306688327 > ./result_8chains/node157_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_5_1 -p 747 -st topic157_5_0 -pt topic157_5_1 -u 0.029221318710327432 > ./result_8chains/node157_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_6_1 -p 983 -st topic157_6_0 -pt topic157_6_1 -u 0.003933752336940072 > ./result_8chains/node157_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node157_7_1 -p 997 -st topic157_7_0 -pt topic157_7_1 -u 0.002265579235118118 > ./result_8chains/node157_7_1.txt &
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
    "./result_8chains/node157_0_1.txt 90"
    "./result_8chains/node157_1_1.txt 89"
    "./result_8chains/node157_2_1.txt 88"
    "./result_8chains/node157_3_1.txt 87"
    "./result_8chains/node157_4_1.txt 86"
    "./result_8chains/node157_5_1.txt 85"
    "./result_8chains/node157_6_1.txt 84"
    "./result_8chains/node157_7_1.txt 83"
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
