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
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_2 -p 216 -st topic446_0_1 -pt None -u 0.06158327726025198 > ./result_6chains/node446_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_2 -p 385 -st topic446_1_1 -pt None -u 0.035620432344013686 > ./result_6chains/node446_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_2 -p 393 -st topic446_2_1 -pt None -u 0.02717921321578254 > ./result_6chains/node446_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_2 -p 405 -st topic446_3_1 -pt None -u 0.002161514260459324 > ./result_6chains/node446_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_2 -p 521 -st topic446_4_1 -pt None -u 0.03527746658350074 > ./result_6chains/node446_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_2 -p 951 -st topic446_5_1 -pt None -u 0.007308830358311092 > ./result_6chains/node446_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_0 -p 216 -st none -pt topic446_0_0 -u 0.02488360526987543 > ./result_6chains/node446_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_0 -p 385 -st none -pt topic446_1_0 -u 0.010211486521927382 > ./result_6chains/node446_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_0 -p 393 -st none -pt topic446_2_0 -u 0.0034416364848274816 > ./result_6chains/node446_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_0 -p 405 -st none -pt topic446_3_0 -u 0.0219808257116762 > ./result_6chains/node446_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_0 -p 521 -st none -pt topic446_4_0 -u 0.04125638719880492 > ./result_6chains/node446_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_0 -p 951 -st none -pt topic446_5_0 -u 0.003060582563537702 > ./result_6chains/node446_5_0.txt &
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
    "./result_6chains/node446_0_0.txt 90"
    "./result_6chains/node446_0_2.txt 90"
    "./result_6chains/node446_1_0.txt 89"
    "./result_6chains/node446_1_2.txt 89"
    "./result_6chains/node446_2_0.txt 88"
    "./result_6chains/node446_2_2.txt 88"
    "./result_6chains/node446_3_0.txt 87"
    "./result_6chains/node446_3_2.txt 87"
    "./result_6chains/node446_4_0.txt 86"
    "./result_6chains/node446_4_2.txt 86"
    "./result_6chains/node446_5_0.txt 85"
    "./result_6chains/node446_5_2.txt 85"
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
