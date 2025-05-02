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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_2 -p 39 -st topic45_0_1 -pt None -u 0.019652554721835247 > ./result_8chains/node45_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_2 -p 89 -st topic45_1_1 -pt None -u 0.0075632813257881515 > ./result_8chains/node45_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_2 -p 152 -st topic45_2_1 -pt None -u 0.005816409969929881 > ./result_8chains/node45_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_2 -p 239 -st topic45_3_1 -pt None -u 0.010948678636487685 > ./result_8chains/node45_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_2 -p 667 -st topic45_4_1 -pt None -u 0.02870297732082633 > ./result_8chains/node45_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_2 -p 700 -st topic45_5_1 -pt None -u 0.0324574130115247 > ./result_8chains/node45_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_2 -p 844 -st topic45_6_1 -pt None -u 0.05226310133037296 > ./result_8chains/node45_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_2 -p 846 -st topic45_7_1 -pt None -u 0.006899974005181266 > ./result_8chains/node45_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_0 -p 39 -st none -pt topic45_0_0 -u 0.023134851901180198 > ./result_8chains/node45_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_0 -p 89 -st none -pt topic45_1_0 -u 0.015593124143579828 > ./result_8chains/node45_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_0 -p 152 -st none -pt topic45_2_0 -u 0.006666308050915226 > ./result_8chains/node45_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_0 -p 239 -st none -pt topic45_3_0 -u 0.01234286577436855 > ./result_8chains/node45_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_0 -p 667 -st none -pt topic45_4_0 -u 0.04650244590651592 > ./result_8chains/node45_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_0 -p 700 -st none -pt topic45_5_0 -u 0.004581240819227478 > ./result_8chains/node45_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_0 -p 844 -st none -pt topic45_6_0 -u 0.039284800905277084 > ./result_8chains/node45_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_0 -p 846 -st none -pt topic45_7_0 -u 0.007887924366497295 > ./result_8chains/node45_7_0.txt &
sleep 10
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
    "./result_8chains/node45_0_0.txt 90"
    "./result_8chains/node45_0_2.txt 90"
    "./result_8chains/node45_1_0.txt 89"
    "./result_8chains/node45_1_2.txt 89"
    "./result_8chains/node45_2_0.txt 88"
    "./result_8chains/node45_2_2.txt 88"
    "./result_8chains/node45_3_0.txt 87"
    "./result_8chains/node45_3_2.txt 87"
    "./result_8chains/node45_4_0.txt 86"
    "./result_8chains/node45_4_2.txt 86"
    "./result_8chains/node45_5_0.txt 85"
    "./result_8chains/node45_5_2.txt 85"
    "./result_8chains/node45_6_0.txt 84"
    "./result_8chains/node45_6_2.txt 84"
    "./result_8chains/node45_7_0.txt 83"
    "./result_8chains/node45_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
