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
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_1 -p 48 -st topic114_0_0 -pt topic114_0_1 -u 0.034652873048919564 > ./result_10chains/node114_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_1 -p 185 -st topic114_1_0 -pt topic114_1_1 -u 0.012586977197588 > ./result_10chains/node114_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_1 -p 288 -st topic114_2_0 -pt topic114_2_1 -u 0.032695696864076085 > ./result_10chains/node114_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_1 -p 305 -st topic114_3_0 -pt topic114_3_1 -u 0.008878262730825537 > ./result_10chains/node114_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_1 -p 393 -st topic114_4_0 -pt topic114_4_1 -u 0.008855599423216454 > ./result_10chains/node114_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_1 -p 737 -st topic114_5_0 -pt topic114_5_1 -u 0.031107354233547158 > ./result_10chains/node114_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_1 -p 799 -st topic114_6_0 -pt topic114_6_1 -u 0.013222863385041916 > ./result_10chains/node114_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_1 -p 904 -st topic114_7_0 -pt topic114_7_1 -u 0.0036614131555756935 > ./result_10chains/node114_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_8_1 -p 941 -st topic114_8_0 -pt topic114_8_1 -u 0.031198539775863274 > ./result_10chains/node114_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_9_1 -p 971 -st topic114_9_0 -pt topic114_9_1 -u 0.014100521238382489 > ./result_10chains/node114_9_1.txt &
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
    "./result_10chains/node114_0_1.txt 90"
    "./result_10chains/node114_1_1.txt 89"
    "./result_10chains/node114_2_1.txt 88"
    "./result_10chains/node114_3_1.txt 87"
    "./result_10chains/node114_4_1.txt 86"
    "./result_10chains/node114_5_1.txt 85"
    "./result_10chains/node114_6_1.txt 84"
    "./result_10chains/node114_7_1.txt 83"
    "./result_10chains/node114_8_1.txt 82"
    "./result_10chains/node114_9_1.txt 81"
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
