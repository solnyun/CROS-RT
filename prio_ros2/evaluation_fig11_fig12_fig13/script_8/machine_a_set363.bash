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
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_2 -p 105 -st topic363_0_1 -pt None -u 0.02824962045243734 > ./result_8chains/node363_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_2 -p 132 -st topic363_1_1 -pt None -u 0.0063898117211673156 > ./result_8chains/node363_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_2 -p 172 -st topic363_2_1 -pt None -u 0.03621586369235413 > ./result_8chains/node363_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_2 -p 313 -st topic363_3_1 -pt None -u 0.006896255827784414 > ./result_8chains/node363_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_2 -p 815 -st topic363_4_1 -pt None -u 0.0007236593588424711 > ./result_8chains/node363_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_2 -p 852 -st topic363_5_1 -pt None -u 0.0005927506514305236 > ./result_8chains/node363_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_2 -p 866 -st topic363_6_1 -pt None -u 0.016985137701262587 > ./result_8chains/node363_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_2 -p 992 -st topic363_7_1 -pt None -u 0.02610103519248348 > ./result_8chains/node363_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_0 -p 105 -st none -pt topic363_0_0 -u 0.0007723308686390373 > ./result_8chains/node363_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_0 -p 132 -st none -pt topic363_1_0 -u 0.006760155457603612 > ./result_8chains/node363_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_0 -p 172 -st none -pt topic363_2_0 -u 0.0013418116378053901 > ./result_8chains/node363_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_0 -p 313 -st none -pt topic363_3_0 -u 0.04668984779882718 > ./result_8chains/node363_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_0 -p 815 -st none -pt topic363_4_0 -u 0.02226063124283567 > ./result_8chains/node363_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_0 -p 852 -st none -pt topic363_5_0 -u 0.016965743746957085 > ./result_8chains/node363_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_0 -p 866 -st none -pt topic363_6_0 -u 0.08257291385890317 > ./result_8chains/node363_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_0 -p 992 -st none -pt topic363_7_0 -u 0.03731894362727302 > ./result_8chains/node363_7_0.txt &
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
    "./result_8chains/node363_0_0.txt 90"
    "./result_8chains/node363_0_2.txt 90"
    "./result_8chains/node363_1_0.txt 89"
    "./result_8chains/node363_1_2.txt 89"
    "./result_8chains/node363_2_0.txt 88"
    "./result_8chains/node363_2_2.txt 88"
    "./result_8chains/node363_3_0.txt 87"
    "./result_8chains/node363_3_2.txt 87"
    "./result_8chains/node363_4_0.txt 86"
    "./result_8chains/node363_4_2.txt 86"
    "./result_8chains/node363_5_0.txt 85"
    "./result_8chains/node363_5_2.txt 85"
    "./result_8chains/node363_6_0.txt 84"
    "./result_8chains/node363_6_2.txt 84"
    "./result_8chains/node363_7_0.txt 83"
    "./result_8chains/node363_7_2.txt 83"
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
