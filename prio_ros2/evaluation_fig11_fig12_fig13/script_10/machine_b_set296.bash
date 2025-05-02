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
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_1 -p 22 -st topic296_0_0 -pt topic296_0_1 -u 0.02311810406915027 > ./result_10chains/node296_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_1 -p 98 -st topic296_1_0 -pt topic296_1_1 -u 0.0023856765566239724 > ./result_10chains/node296_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_1 -p 112 -st topic296_2_0 -pt topic296_2_1 -u 0.009408396536485675 > ./result_10chains/node296_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_1 -p 165 -st topic296_3_0 -pt topic296_3_1 -u 0.045964438755702275 > ./result_10chains/node296_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_1 -p 167 -st topic296_4_0 -pt topic296_4_1 -u 0.031602205006793005 > ./result_10chains/node296_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_1 -p 245 -st topic296_5_0 -pt topic296_5_1 -u 0.010996005571020318 > ./result_10chains/node296_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_1 -p 393 -st topic296_6_0 -pt topic296_6_1 -u 0.013052008361080683 > ./result_10chains/node296_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_1 -p 449 -st topic296_7_0 -pt topic296_7_1 -u 0.0021914503984956646 > ./result_10chains/node296_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_8_1 -p 662 -st topic296_8_0 -pt topic296_8_1 -u 0.029194181152402174 > ./result_10chains/node296_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_9_1 -p 707 -st topic296_9_0 -pt topic296_9_1 -u 0.0015332209443532205 > ./result_10chains/node296_9_1.txt &
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
    "./result_10chains/node296_0_1.txt 90"
    "./result_10chains/node296_1_1.txt 89"
    "./result_10chains/node296_2_1.txt 88"
    "./result_10chains/node296_3_1.txt 87"
    "./result_10chains/node296_4_1.txt 86"
    "./result_10chains/node296_5_1.txt 85"
    "./result_10chains/node296_6_1.txt 84"
    "./result_10chains/node296_7_1.txt 83"
    "./result_10chains/node296_8_1.txt 82"
    "./result_10chains/node296_9_1.txt 81"
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
