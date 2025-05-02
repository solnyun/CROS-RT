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
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_1 -p 267 -st topic122_0_0 -pt topic122_0_1 -u 0.00699343724823509 > ./result_8chains/node122_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_1 -p 337 -st topic122_1_0 -pt topic122_1_1 -u 0.04519414419018997 > ./result_8chains/node122_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_1 -p 352 -st topic122_2_0 -pt topic122_2_1 -u 0.015816413151523656 > ./result_8chains/node122_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_1 -p 375 -st topic122_3_0 -pt topic122_3_1 -u 0.015717143977697856 > ./result_8chains/node122_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_1 -p 412 -st topic122_4_0 -pt topic122_4_1 -u 0.032355974428122825 > ./result_8chains/node122_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_1 -p 571 -st topic122_5_0 -pt topic122_5_1 -u 0.023719379834740845 > ./result_8chains/node122_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_1 -p 602 -st topic122_6_0 -pt topic122_6_1 -u 0.021583357942528955 > ./result_8chains/node122_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_1 -p 849 -st topic122_7_0 -pt topic122_7_1 -u 0.013067492336527167 > ./result_8chains/node122_7_1.txt &
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
    "./result_8chains/node122_0_1.txt 90"
    "./result_8chains/node122_1_1.txt 89"
    "./result_8chains/node122_2_1.txt 88"
    "./result_8chains/node122_3_1.txt 87"
    "./result_8chains/node122_4_1.txt 86"
    "./result_8chains/node122_5_1.txt 85"
    "./result_8chains/node122_6_1.txt 84"
    "./result_8chains/node122_7_1.txt 83"
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
