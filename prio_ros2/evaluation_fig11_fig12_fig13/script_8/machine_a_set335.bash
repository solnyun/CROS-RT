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
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_2 -p 14 -st topic335_0_1 -pt None -u 0.00981319642005457 > ./result_8chains/node335_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_2 -p 241 -st topic335_1_1 -pt None -u 0.012494183959247951 > ./result_8chains/node335_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_2 -p 299 -st topic335_2_1 -pt None -u 0.0032105813548322093 > ./result_8chains/node335_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_2 -p 392 -st topic335_3_1 -pt None -u 0.11659498185897674 > ./result_8chains/node335_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_2 -p 877 -st topic335_4_1 -pt None -u 0.0004142462353563525 > ./result_8chains/node335_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_2 -p 897 -st topic335_5_1 -pt None -u 0.006774347465972004 > ./result_8chains/node335_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_2 -p 905 -st topic335_6_1 -pt None -u 0.008315912651027449 > ./result_8chains/node335_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_2 -p 955 -st topic335_7_1 -pt None -u 0.012668824392983185 > ./result_8chains/node335_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_0 -p 14 -st none -pt topic335_0_0 -u 0.020597773605636305 > ./result_8chains/node335_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_0 -p 241 -st none -pt topic335_1_0 -u 0.013443945993686424 > ./result_8chains/node335_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_0 -p 299 -st none -pt topic335_2_0 -u 0.018943969566023733 > ./result_8chains/node335_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_0 -p 392 -st none -pt topic335_3_0 -u 0.03888246650319027 > ./result_8chains/node335_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_0 -p 877 -st none -pt topic335_4_0 -u 0.010524796975848488 > ./result_8chains/node335_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_0 -p 897 -st none -pt topic335_5_0 -u 0.0785177819654156 > ./result_8chains/node335_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_0 -p 905 -st none -pt topic335_6_0 -u 0.0008240039657199522 > ./result_8chains/node335_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_0 -p 955 -st none -pt topic335_7_0 -u 0.004676216898450443 > ./result_8chains/node335_7_0.txt &
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
    "./result_8chains/node335_0_0.txt 90"
    "./result_8chains/node335_0_2.txt 90"
    "./result_8chains/node335_1_0.txt 89"
    "./result_8chains/node335_1_2.txt 89"
    "./result_8chains/node335_2_0.txt 88"
    "./result_8chains/node335_2_2.txt 88"
    "./result_8chains/node335_3_0.txt 87"
    "./result_8chains/node335_3_2.txt 87"
    "./result_8chains/node335_4_0.txt 86"
    "./result_8chains/node335_4_2.txt 86"
    "./result_8chains/node335_5_0.txt 85"
    "./result_8chains/node335_5_2.txt 85"
    "./result_8chains/node335_6_0.txt 84"
    "./result_8chains/node335_6_2.txt 84"
    "./result_8chains/node335_7_0.txt 83"
    "./result_8chains/node335_7_2.txt 83"
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
