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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_1 -p 59 -st topic381_0_0 -pt topic381_0_1 -u 0.0017059019449498503 > ./result_8chains/node381_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_1 -p 64 -st topic381_1_0 -pt topic381_1_1 -u 0.014625156139404738 > ./result_8chains/node381_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_1 -p 92 -st topic381_2_0 -pt topic381_2_1 -u 0.021109774315861696 > ./result_8chains/node381_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_1 -p 225 -st topic381_3_0 -pt topic381_3_1 -u 0.011787006232834796 > ./result_8chains/node381_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_1 -p 549 -st topic381_4_0 -pt topic381_4_1 -u 0.025432158313491854 > ./result_8chains/node381_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_1 -p 696 -st topic381_5_0 -pt topic381_5_1 -u 0.0027642862773762933 > ./result_8chains/node381_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_1 -p 865 -st topic381_6_0 -pt topic381_6_1 -u 0.010813936364402033 > ./result_8chains/node381_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_1 -p 880 -st topic381_7_0 -pt topic381_7_1 -u 0.053243963121778135 > ./result_8chains/node381_7_1.txt &
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
    "./result_8chains/node381_0_1.txt 90"
    "./result_8chains/node381_1_1.txt 89"
    "./result_8chains/node381_2_1.txt 88"
    "./result_8chains/node381_3_1.txt 87"
    "./result_8chains/node381_4_1.txt 86"
    "./result_8chains/node381_5_1.txt 85"
    "./result_8chains/node381_6_1.txt 84"
    "./result_8chains/node381_7_1.txt 83"
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
