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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_1 -p 97 -st topic409_0_0 -pt topic409_0_1 -u 0.003003009234606724 > ./result_8chains/node409_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_1 -p 355 -st topic409_1_0 -pt topic409_1_1 -u 0.01673584544145662 > ./result_8chains/node409_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_1 -p 467 -st topic409_2_0 -pt topic409_2_1 -u 0.01518998043550951 > ./result_8chains/node409_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_1 -p 521 -st topic409_3_0 -pt topic409_3_1 -u 0.018986754243711074 > ./result_8chains/node409_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_1 -p 615 -st topic409_4_0 -pt topic409_4_1 -u 0.019713713967965507 > ./result_8chains/node409_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_1 -p 630 -st topic409_5_0 -pt topic409_5_1 -u 0.014288252072278435 > ./result_8chains/node409_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_1 -p 777 -st topic409_6_0 -pt topic409_6_1 -u 0.01116928362580212 > ./result_8chains/node409_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_1 -p 813 -st topic409_7_0 -pt topic409_7_1 -u 0.008373854463581739 > ./result_8chains/node409_7_1.txt &
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
    "./result_8chains/node409_0_1.txt 90"
    "./result_8chains/node409_1_1.txt 89"
    "./result_8chains/node409_2_1.txt 88"
    "./result_8chains/node409_3_1.txt 87"
    "./result_8chains/node409_4_1.txt 86"
    "./result_8chains/node409_5_1.txt 85"
    "./result_8chains/node409_6_1.txt 84"
    "./result_8chains/node409_7_1.txt 83"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
