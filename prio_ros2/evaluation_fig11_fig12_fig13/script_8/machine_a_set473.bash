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
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_2 -p 127 -st topic473_0_1 -pt None -u 0.033487616586401925 > ./result_8chains/node473_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_2 -p 178 -st topic473_1_1 -pt None -u 0.007702685859307834 > ./result_8chains/node473_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_2 -p 181 -st topic473_2_1 -pt None -u 0.016801420314535354 > ./result_8chains/node473_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_2 -p 335 -st topic473_3_1 -pt None -u 0.011145957419990027 > ./result_8chains/node473_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_2 -p 487 -st topic473_4_1 -pt None -u 0.017323656325658215 > ./result_8chains/node473_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_2 -p 502 -st topic473_5_1 -pt None -u 0.025423425669190314 > ./result_8chains/node473_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_6_2 -p 524 -st topic473_6_1 -pt None -u 0.007584958410492504 > ./result_8chains/node473_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_7_2 -p 945 -st topic473_7_1 -pt None -u 0.008685494643532438 > ./result_8chains/node473_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_0 -p 127 -st none -pt topic473_0_0 -u 0.00462804565704078 > ./result_8chains/node473_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_0 -p 178 -st none -pt topic473_1_0 -u 0.05474451579834888 > ./result_8chains/node473_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_0 -p 181 -st none -pt topic473_2_0 -u 0.03335145803762962 > ./result_8chains/node473_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_0 -p 335 -st none -pt topic473_3_0 -u 0.019587214968390942 > ./result_8chains/node473_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_0 -p 487 -st none -pt topic473_4_0 -u 0.005745501776502848 > ./result_8chains/node473_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_0 -p 502 -st none -pt topic473_5_0 -u 0.005970000622150445 > ./result_8chains/node473_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_6_0 -p 524 -st none -pt topic473_6_0 -u 0.005827467591184188 > ./result_8chains/node473_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_7_0 -p 945 -st none -pt topic473_7_0 -u 0.0669453778444417 > ./result_8chains/node473_7_0.txt &
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
    "./result_8chains/node473_0_0.txt 90"
    "./result_8chains/node473_0_2.txt 90"
    "./result_8chains/node473_1_0.txt 89"
    "./result_8chains/node473_1_2.txt 89"
    "./result_8chains/node473_2_0.txt 88"
    "./result_8chains/node473_2_2.txt 88"
    "./result_8chains/node473_3_0.txt 87"
    "./result_8chains/node473_3_2.txt 87"
    "./result_8chains/node473_4_0.txt 86"
    "./result_8chains/node473_4_2.txt 86"
    "./result_8chains/node473_5_0.txt 85"
    "./result_8chains/node473_5_2.txt 85"
    "./result_8chains/node473_6_0.txt 84"
    "./result_8chains/node473_6_2.txt 84"
    "./result_8chains/node473_7_0.txt 83"
    "./result_8chains/node473_7_2.txt 83"
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
