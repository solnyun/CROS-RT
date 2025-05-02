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
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_2 -p 182 -st topic481_0_1 -pt None -u 0.007957855593471008 > ./result_6chains/node481_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_2 -p 183 -st topic481_1_1 -pt None -u 0.06059840154605528 > ./result_6chains/node481_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_2 -p 229 -st topic481_2_1 -pt None -u 0.014924570976765972 > ./result_6chains/node481_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_2 -p 249 -st topic481_3_1 -pt None -u 0.025865320539186554 > ./result_6chains/node481_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_2 -p 384 -st topic481_4_1 -pt None -u 0.009873911133864016 > ./result_6chains/node481_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_2 -p 473 -st topic481_5_1 -pt None -u 0.07387444694410968 > ./result_6chains/node481_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_0 -p 182 -st none -pt topic481_0_0 -u 0.016831400359686333 > ./result_6chains/node481_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_0 -p 183 -st none -pt topic481_1_0 -u 0.00047723556239670506 > ./result_6chains/node481_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_0 -p 229 -st none -pt topic481_2_0 -u 0.004136490151401495 > ./result_6chains/node481_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_0 -p 249 -st none -pt topic481_3_0 -u 0.02678328045195194 > ./result_6chains/node481_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_0 -p 384 -st none -pt topic481_4_0 -u 0.06027947689714086 > ./result_6chains/node481_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_0 -p 473 -st none -pt topic481_5_0 -u 0.05546211901705787 > ./result_6chains/node481_5_0.txt &
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
    "./result_6chains/node481_0_0.txt 90"
    "./result_6chains/node481_0_2.txt 90"
    "./result_6chains/node481_1_0.txt 89"
    "./result_6chains/node481_1_2.txt 89"
    "./result_6chains/node481_2_0.txt 88"
    "./result_6chains/node481_2_2.txt 88"
    "./result_6chains/node481_3_0.txt 87"
    "./result_6chains/node481_3_2.txt 87"
    "./result_6chains/node481_4_0.txt 86"
    "./result_6chains/node481_4_2.txt 86"
    "./result_6chains/node481_5_0.txt 85"
    "./result_6chains/node481_5_2.txt 85"
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
