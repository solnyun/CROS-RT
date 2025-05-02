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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_2 -p 215 -st topic31_0_1 -pt None -u 0.028103495251819655 > ./result_4chains/node31_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_2 -p 403 -st topic31_1_1 -pt None -u 0.0026971238020028765 > ./result_4chains/node31_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_2 -p 547 -st topic31_2_1 -pt None -u 0.033622231583008505 > ./result_4chains/node31_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_2 -p 814 -st topic31_3_1 -pt None -u 0.03527112588329924 > ./result_4chains/node31_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_0 -p 215 -st none -pt topic31_0_0 -u 0.00529725989191937 > ./result_4chains/node31_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_0 -p 403 -st none -pt topic31_1_0 -u 0.089018983885784 > ./result_4chains/node31_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_0 -p 547 -st none -pt topic31_2_0 -u 0.010696605592760755 > ./result_4chains/node31_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_0 -p 814 -st none -pt topic31_3_0 -u 0.12754493044108567 > ./result_4chains/node31_3_0.txt &
sleep 10
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
    "./result_4chains/node31_0_0.txt 90"
    "./result_4chains/node31_0_2.txt 90"
    "./result_4chains/node31_1_0.txt 89"
    "./result_4chains/node31_1_2.txt 89"
    "./result_4chains/node31_2_0.txt 88"
    "./result_4chains/node31_2_2.txt 88"
    "./result_4chains/node31_3_0.txt 87"
    "./result_4chains/node31_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
