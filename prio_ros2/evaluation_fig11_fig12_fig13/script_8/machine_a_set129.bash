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
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_2 -p 93 -st topic129_0_1 -pt None -u 0.020119036775579635 > ./result_8chains/node129_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_2 -p 123 -st topic129_1_1 -pt None -u 0.01481768025656266 > ./result_8chains/node129_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_2 -p 246 -st topic129_2_1 -pt None -u 0.013139167868514323 > ./result_8chains/node129_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_2 -p 257 -st topic129_3_1 -pt None -u 0.008325169396962095 > ./result_8chains/node129_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_2 -p 407 -st topic129_4_1 -pt None -u 0.02799432686811168 > ./result_8chains/node129_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_2 -p 575 -st topic129_5_1 -pt None -u 0.04194675241553672 > ./result_8chains/node129_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_6_2 -p 825 -st topic129_6_1 -pt None -u 0.0031862173330297963 > ./result_8chains/node129_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_7_2 -p 933 -st topic129_7_1 -pt None -u 0.00306728353152246 > ./result_8chains/node129_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_0 -p 93 -st none -pt topic129_0_0 -u 0.001944764580735836 > ./result_8chains/node129_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_0 -p 123 -st none -pt topic129_1_0 -u 0.0156725664194155 > ./result_8chains/node129_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_0 -p 246 -st none -pt topic129_2_0 -u 0.03895043165814205 > ./result_8chains/node129_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_0 -p 257 -st none -pt topic129_3_0 -u 0.007359734625339176 > ./result_8chains/node129_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_0 -p 407 -st none -pt topic129_4_0 -u 0.006318979927099344 > ./result_8chains/node129_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_0 -p 575 -st none -pt topic129_5_0 -u 0.004855043984490909 > ./result_8chains/node129_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_6_0 -p 825 -st none -pt topic129_6_0 -u 0.09662256420248999 > ./result_8chains/node129_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_7_0 -p 933 -st none -pt topic129_7_0 -u 0.00267258323309668 > ./result_8chains/node129_7_0.txt &
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
    "./result_8chains/node129_0_0.txt 90"
    "./result_8chains/node129_0_2.txt 90"
    "./result_8chains/node129_1_0.txt 89"
    "./result_8chains/node129_1_2.txt 89"
    "./result_8chains/node129_2_0.txt 88"
    "./result_8chains/node129_2_2.txt 88"
    "./result_8chains/node129_3_0.txt 87"
    "./result_8chains/node129_3_2.txt 87"
    "./result_8chains/node129_4_0.txt 86"
    "./result_8chains/node129_4_2.txt 86"
    "./result_8chains/node129_5_0.txt 85"
    "./result_8chains/node129_5_2.txt 85"
    "./result_8chains/node129_6_0.txt 84"
    "./result_8chains/node129_6_2.txt 84"
    "./result_8chains/node129_7_0.txt 83"
    "./result_8chains/node129_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
