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
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_1 -p 151 -st topic198_0_0 -pt topic198_0_1 -u 0.010123015705818916 > ./result_10chains/node198_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_1 -p 287 -st topic198_1_0 -pt topic198_1_1 -u 0.022288055569546494 > ./result_10chains/node198_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_1 -p 305 -st topic198_2_0 -pt topic198_2_1 -u 0.02656638951903767 > ./result_10chains/node198_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_1 -p 363 -st topic198_3_0 -pt topic198_3_1 -u 0.0710222960197226 > ./result_10chains/node198_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_1 -p 518 -st topic198_4_0 -pt topic198_4_1 -u 0.0052161740549405144 > ./result_10chains/node198_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_1 -p 533 -st topic198_5_0 -pt topic198_5_1 -u 0.020179380499980415 > ./result_10chains/node198_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_1 -p 751 -st topic198_6_0 -pt topic198_6_1 -u 0.026668751265209595 > ./result_10chains/node198_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_1 -p 794 -st topic198_7_0 -pt topic198_7_1 -u 0.017054976560130747 > ./result_10chains/node198_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_8_1 -p 800 -st topic198_8_0 -pt topic198_8_1 -u 0.013485807919246195 > ./result_10chains/node198_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_9_1 -p 911 -st topic198_9_0 -pt topic198_9_1 -u 0.00278773178959903 > ./result_10chains/node198_9_1.txt &
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
    "./result_10chains/node198_0_1.txt 90"
    "./result_10chains/node198_1_1.txt 89"
    "./result_10chains/node198_2_1.txt 88"
    "./result_10chains/node198_3_1.txt 87"
    "./result_10chains/node198_4_1.txt 86"
    "./result_10chains/node198_5_1.txt 85"
    "./result_10chains/node198_6_1.txt 84"
    "./result_10chains/node198_7_1.txt 83"
    "./result_10chains/node198_8_1.txt 82"
    "./result_10chains/node198_9_1.txt 81"
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
