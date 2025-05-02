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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_2 -p 184 -st topic345_0_1 -pt None -u 0.037115454558008854 > ./result_8chains/node345_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_2 -p 191 -st topic345_1_1 -pt None -u 0.0074667576926101265 > ./result_8chains/node345_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_2 -p 644 -st topic345_2_1 -pt None -u 0.06640750476724835 > ./result_8chains/node345_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_2 -p 715 -st topic345_3_1 -pt None -u 0.0373775137555421 > ./result_8chains/node345_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_2 -p 785 -st topic345_4_1 -pt None -u 0.005162854944405937 > ./result_8chains/node345_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_2 -p 829 -st topic345_5_1 -pt None -u 0.00036551713255546237 > ./result_8chains/node345_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_2 -p 855 -st topic345_6_1 -pt None -u 0.009545297761824587 > ./result_8chains/node345_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_2 -p 936 -st topic345_7_1 -pt None -u 0.0009787464137965495 > ./result_8chains/node345_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_0 -p 184 -st none -pt topic345_0_0 -u 0.01963564583725158 > ./result_8chains/node345_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_0 -p 191 -st none -pt topic345_1_0 -u 0.019804611352720658 > ./result_8chains/node345_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_0 -p 644 -st none -pt topic345_2_0 -u 0.036679689682702854 > ./result_8chains/node345_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_0 -p 715 -st none -pt topic345_3_0 -u 0.009625498724612824 > ./result_8chains/node345_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_0 -p 785 -st none -pt topic345_4_0 -u 0.021022388076053083 > ./result_8chains/node345_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_0 -p 829 -st none -pt topic345_5_0 -u 0.004568493463989867 > ./result_8chains/node345_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_0 -p 855 -st none -pt topic345_6_0 -u 0.01720579954170537 > ./result_8chains/node345_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_0 -p 936 -st none -pt topic345_7_0 -u 0.02307368966935404 > ./result_8chains/node345_7_0.txt &
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
    "./result_8chains/node345_0_0.txt 90"
    "./result_8chains/node345_0_2.txt 90"
    "./result_8chains/node345_1_0.txt 89"
    "./result_8chains/node345_1_2.txt 89"
    "./result_8chains/node345_2_0.txt 88"
    "./result_8chains/node345_2_2.txt 88"
    "./result_8chains/node345_3_0.txt 87"
    "./result_8chains/node345_3_2.txt 87"
    "./result_8chains/node345_4_0.txt 86"
    "./result_8chains/node345_4_2.txt 86"
    "./result_8chains/node345_5_0.txt 85"
    "./result_8chains/node345_5_2.txt 85"
    "./result_8chains/node345_6_0.txt 84"
    "./result_8chains/node345_6_2.txt 84"
    "./result_8chains/node345_7_0.txt 83"
    "./result_8chains/node345_7_2.txt 83"
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
