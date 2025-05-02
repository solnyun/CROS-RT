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
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_2 -p 40 -st topic86_0_1 -pt None -u 0.0146016613578413 > ./result_6chains/node86_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_2 -p 51 -st topic86_1_1 -pt None -u 0.058729180679400306 > ./result_6chains/node86_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_2 -p 112 -st topic86_2_1 -pt None -u 0.005889452967485886 > ./result_6chains/node86_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_2 -p 238 -st topic86_3_1 -pt None -u 0.017693369940406434 > ./result_6chains/node86_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_2 -p 259 -st topic86_4_1 -pt None -u 0.04255163523109469 > ./result_6chains/node86_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_2 -p 540 -st topic86_5_1 -pt None -u 0.012598839552945945 > ./result_6chains/node86_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_0 -p 40 -st none -pt topic86_0_0 -u 0.015515396159346329 > ./result_6chains/node86_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_0 -p 51 -st none -pt topic86_1_0 -u 0.01330364333730244 > ./result_6chains/node86_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_0 -p 112 -st none -pt topic86_2_0 -u 0.026148035632852673 > ./result_6chains/node86_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_0 -p 238 -st none -pt topic86_3_0 -u 0.0030132432953192123 > ./result_6chains/node86_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_0 -p 259 -st none -pt topic86_4_0 -u 0.06881110832429596 > ./result_6chains/node86_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_0 -p 540 -st none -pt topic86_5_0 -u 0.03712883965268239 > ./result_6chains/node86_5_0.txt &
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
    "./result_6chains/node86_0_0.txt 90"
    "./result_6chains/node86_0_2.txt 90"
    "./result_6chains/node86_1_0.txt 89"
    "./result_6chains/node86_1_2.txt 89"
    "./result_6chains/node86_2_0.txt 88"
    "./result_6chains/node86_2_2.txt 88"
    "./result_6chains/node86_3_0.txt 87"
    "./result_6chains/node86_3_2.txt 87"
    "./result_6chains/node86_4_0.txt 86"
    "./result_6chains/node86_4_2.txt 86"
    "./result_6chains/node86_5_0.txt 85"
    "./result_6chains/node86_5_2.txt 85"
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
