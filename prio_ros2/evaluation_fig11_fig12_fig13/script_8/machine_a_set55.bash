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
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_2 -p 210 -st topic55_0_1 -pt None -u 0.06231782471900893 > ./result_8chains/node55_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_2 -p 219 -st topic55_1_1 -pt None -u 0.020151063130962543 > ./result_8chains/node55_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_2 -p 330 -st topic55_2_1 -pt None -u 0.0002188994037931602 > ./result_8chains/node55_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_2 -p 404 -st topic55_3_1 -pt None -u 3.275972305216701e-05 > ./result_8chains/node55_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_2 -p 605 -st topic55_4_1 -pt None -u 0.007130378027828066 > ./result_8chains/node55_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_2 -p 659 -st topic55_5_1 -pt None -u 0.025433546082517938 > ./result_8chains/node55_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_6_2 -p 950 -st topic55_6_1 -pt None -u 0.00036474168791804373 > ./result_8chains/node55_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_7_2 -p 956 -st topic55_7_1 -pt None -u 0.013203766359275075 > ./result_8chains/node55_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_0_0 -p 210 -st none -pt topic55_0_0 -u 0.008598155183743128 > ./result_8chains/node55_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_1_0 -p 219 -st none -pt topic55_1_0 -u 0.02792357418348823 > ./result_8chains/node55_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_2_0 -p 330 -st none -pt topic55_2_0 -u 0.007700010586020767 > ./result_8chains/node55_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_3_0 -p 404 -st none -pt topic55_3_0 -u 0.019719262411483862 > ./result_8chains/node55_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_4_0 -p 605 -st none -pt topic55_4_0 -u 0.01792519390200631 > ./result_8chains/node55_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_5_0 -p 659 -st none -pt topic55_5_0 -u 0.07352879712160348 > ./result_8chains/node55_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node55_6_0 -p 950 -st none -pt topic55_6_0 -u 0.0028693014128499533 > ./result_8chains/node55_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node55_7_0 -p 956 -st none -pt topic55_7_0 -u 0.01946902635595854 > ./result_8chains/node55_7_0.txt &
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
    "./result_8chains/node55_0_0.txt 90"
    "./result_8chains/node55_0_2.txt 90"
    "./result_8chains/node55_1_0.txt 89"
    "./result_8chains/node55_1_2.txt 89"
    "./result_8chains/node55_2_0.txt 88"
    "./result_8chains/node55_2_2.txt 88"
    "./result_8chains/node55_3_0.txt 87"
    "./result_8chains/node55_3_2.txt 87"
    "./result_8chains/node55_4_0.txt 86"
    "./result_8chains/node55_4_2.txt 86"
    "./result_8chains/node55_5_0.txt 85"
    "./result_8chains/node55_5_2.txt 85"
    "./result_8chains/node55_6_0.txt 84"
    "./result_8chains/node55_6_2.txt 84"
    "./result_8chains/node55_7_0.txt 83"
    "./result_8chains/node55_7_2.txt 83"
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
