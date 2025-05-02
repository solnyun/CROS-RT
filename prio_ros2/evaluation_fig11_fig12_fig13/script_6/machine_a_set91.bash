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
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_2 -p 160 -st topic91_0_1 -pt None -u 0.0020798168192598943 > ./result_6chains/node91_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_2 -p 444 -st topic91_1_1 -pt None -u 0.007845246643780945 > ./result_6chains/node91_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_2 -p 530 -st topic91_2_1 -pt None -u 0.012680613713905386 > ./result_6chains/node91_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_2 -p 547 -st topic91_3_1 -pt None -u 0.011251780889987295 > ./result_6chains/node91_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_2 -p 734 -st topic91_4_1 -pt None -u 0.08489728981297859 > ./result_6chains/node91_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_2 -p 991 -st topic91_5_1 -pt None -u 0.014209548023961913 > ./result_6chains/node91_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_0 -p 160 -st none -pt topic91_0_0 -u 0.03615233361905096 > ./result_6chains/node91_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_0 -p 444 -st none -pt topic91_1_0 -u 0.01868364886154472 > ./result_6chains/node91_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_0 -p 530 -st none -pt topic91_2_0 -u 0.007496222430847244 > ./result_6chains/node91_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_0 -p 547 -st none -pt topic91_3_0 -u 0.03966517234964595 > ./result_6chains/node91_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_0 -p 734 -st none -pt topic91_4_0 -u 0.024482960413135524 > ./result_6chains/node91_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_0 -p 991 -st none -pt topic91_5_0 -u 0.002030762090192921 > ./result_6chains/node91_5_0.txt &
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
    "./result_6chains/node91_0_0.txt 90"
    "./result_6chains/node91_0_2.txt 90"
    "./result_6chains/node91_1_0.txt 89"
    "./result_6chains/node91_1_2.txt 89"
    "./result_6chains/node91_2_0.txt 88"
    "./result_6chains/node91_2_2.txt 88"
    "./result_6chains/node91_3_0.txt 87"
    "./result_6chains/node91_3_2.txt 87"
    "./result_6chains/node91_4_0.txt 86"
    "./result_6chains/node91_4_2.txt 86"
    "./result_6chains/node91_5_0.txt 85"
    "./result_6chains/node91_5_2.txt 85"
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
