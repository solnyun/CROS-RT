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
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_2 -p 27 -st topic463_0_1 -pt None -u 0.01446125664753245 > ./result_6chains/node463_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_2 -p 64 -st topic463_1_1 -pt None -u 0.02140020436899026 > ./result_6chains/node463_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_2 -p 228 -st topic463_2_1 -pt None -u 0.024077570034302276 > ./result_6chains/node463_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_2 -p 750 -st topic463_3_1 -pt None -u 0.031572651088620174 > ./result_6chains/node463_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_2 -p 805 -st topic463_4_1 -pt None -u 0.019425887825102656 > ./result_6chains/node463_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_2 -p 866 -st topic463_5_1 -pt None -u 0.05808319374158819 > ./result_6chains/node463_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_0 -p 27 -st none -pt topic463_0_0 -u 0.00929721187798549 > ./result_6chains/node463_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_0 -p 64 -st none -pt topic463_1_0 -u 0.010208171268457245 > ./result_6chains/node463_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_0 -p 228 -st none -pt topic463_2_0 -u 0.008906377361560969 > ./result_6chains/node463_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_0 -p 750 -st none -pt topic463_3_0 -u 0.040159313324374224 > ./result_6chains/node463_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_0 -p 805 -st none -pt topic463_4_0 -u 0.01531371853359248 > ./result_6chains/node463_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_0 -p 866 -st none -pt topic463_5_0 -u 0.012212574024018985 > ./result_6chains/node463_5_0.txt &
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
    "./result_6chains/node463_0_0.txt 90"
    "./result_6chains/node463_0_2.txt 90"
    "./result_6chains/node463_1_0.txt 89"
    "./result_6chains/node463_1_2.txt 89"
    "./result_6chains/node463_2_0.txt 88"
    "./result_6chains/node463_2_2.txt 88"
    "./result_6chains/node463_3_0.txt 87"
    "./result_6chains/node463_3_2.txt 87"
    "./result_6chains/node463_4_0.txt 86"
    "./result_6chains/node463_4_2.txt 86"
    "./result_6chains/node463_5_0.txt 85"
    "./result_6chains/node463_5_2.txt 85"
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
