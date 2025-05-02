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
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_2 -p 144 -st topic134_0_1 -pt None -u 0.04443034564360815 > ./result_6chains/node134_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_2 -p 196 -st topic134_1_1 -pt None -u 0.05056477396224701 > ./result_6chains/node134_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_2 -p 315 -st topic134_2_1 -pt None -u 0.005608681979550945 > ./result_6chains/node134_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_2 -p 507 -st topic134_3_1 -pt None -u 0.07719710901083698 > ./result_6chains/node134_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_2 -p 703 -st topic134_4_1 -pt None -u 0.007173550042323729 > ./result_6chains/node134_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_2 -p 720 -st topic134_5_1 -pt None -u 0.03852277514944895 > ./result_6chains/node134_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_0 -p 144 -st none -pt topic134_0_0 -u 0.00589878639610425 > ./result_6chains/node134_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_0 -p 196 -st none -pt topic134_1_0 -u 0.049076864552431265 > ./result_6chains/node134_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_0 -p 315 -st none -pt topic134_2_0 -u 0.010441641149648406 > ./result_6chains/node134_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_0 -p 507 -st none -pt topic134_3_0 -u 0.026263786732302008 > ./result_6chains/node134_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_0 -p 703 -st none -pt topic134_4_0 -u 0.030507367801163407 > ./result_6chains/node134_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_0 -p 720 -st none -pt topic134_5_0 -u 0.013040006051466858 > ./result_6chains/node134_5_0.txt &
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
    "./result_6chains/node134_0_0.txt 90"
    "./result_6chains/node134_0_2.txt 90"
    "./result_6chains/node134_1_0.txt 89"
    "./result_6chains/node134_1_2.txt 89"
    "./result_6chains/node134_2_0.txt 88"
    "./result_6chains/node134_2_2.txt 88"
    "./result_6chains/node134_3_0.txt 87"
    "./result_6chains/node134_3_2.txt 87"
    "./result_6chains/node134_4_0.txt 86"
    "./result_6chains/node134_4_2.txt 86"
    "./result_6chains/node134_5_0.txt 85"
    "./result_6chains/node134_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
