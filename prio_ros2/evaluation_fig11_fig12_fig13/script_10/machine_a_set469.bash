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
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_2 -p 200 -st topic469_0_1 -pt None -u 0.06515936483988466 > ./result_10chains/node469_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_2 -p 203 -st topic469_1_1 -pt None -u 0.013535994922914019 > ./result_10chains/node469_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_2 -p 237 -st topic469_2_1 -pt None -u 0.014067050303788797 > ./result_10chains/node469_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_2 -p 329 -st topic469_3_1 -pt None -u 0.03426663146252873 > ./result_10chains/node469_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_2 -p 416 -st topic469_4_1 -pt None -u 0.030084773020881916 > ./result_10chains/node469_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_2 -p 517 -st topic469_5_1 -pt None -u 0.0011336615321862475 > ./result_10chains/node469_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_2 -p 600 -st topic469_6_1 -pt None -u 0.021595753142659657 > ./result_10chains/node469_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_2 -p 638 -st topic469_7_1 -pt None -u 0.00015238116216016728 > ./result_10chains/node469_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_8_2 -p 747 -st topic469_8_1 -pt None -u 0.02362702089692905 > ./result_10chains/node469_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_9_2 -p 790 -st topic469_9_1 -pt None -u 0.007225142148001645 > ./result_10chains/node469_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_0 -p 200 -st none -pt topic469_0_0 -u 0.007730768662123577 > ./result_10chains/node469_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_0 -p 203 -st none -pt topic469_1_0 -u 0.00020146680853178056 > ./result_10chains/node469_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_0 -p 237 -st none -pt topic469_2_0 -u 0.014004989727986084 > ./result_10chains/node469_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_0 -p 329 -st none -pt topic469_3_0 -u 0.025852219985593117 > ./result_10chains/node469_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_0 -p 416 -st none -pt topic469_4_0 -u 0.0019579847770780368 > ./result_10chains/node469_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_0 -p 517 -st none -pt topic469_5_0 -u 0.003346691075300612 > ./result_10chains/node469_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_0 -p 600 -st none -pt topic469_6_0 -u 3.1613887090470305e-05 > ./result_10chains/node469_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_0 -p 638 -st none -pt topic469_7_0 -u 0.0026306348124786882 > ./result_10chains/node469_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_8_0 -p 747 -st none -pt topic469_8_0 -u 0.005732374832147544 > ./result_10chains/node469_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_9_0 -p 790 -st none -pt topic469_9_0 -u 0.036843232504971825 > ./result_10chains/node469_9_0.txt &
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
    "./result_10chains/node469_0_0.txt 90"
    "./result_10chains/node469_0_2.txt 90"
    "./result_10chains/node469_1_0.txt 89"
    "./result_10chains/node469_1_2.txt 89"
    "./result_10chains/node469_2_0.txt 88"
    "./result_10chains/node469_2_2.txt 88"
    "./result_10chains/node469_3_0.txt 87"
    "./result_10chains/node469_3_2.txt 87"
    "./result_10chains/node469_4_0.txt 86"
    "./result_10chains/node469_4_2.txt 86"
    "./result_10chains/node469_5_0.txt 85"
    "./result_10chains/node469_5_2.txt 85"
    "./result_10chains/node469_6_0.txt 84"
    "./result_10chains/node469_6_2.txt 84"
    "./result_10chains/node469_7_0.txt 83"
    "./result_10chains/node469_7_2.txt 83"
    "./result_10chains/node469_8_0.txt 82"
    "./result_10chains/node469_8_2.txt 82"
    "./result_10chains/node469_9_0.txt 81"
    "./result_10chains/node469_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
