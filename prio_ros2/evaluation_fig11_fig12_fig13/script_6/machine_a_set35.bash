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
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_2 -p 82 -st topic35_0_1 -pt None -u 0.04885014137497218 > ./result_6chains/node35_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_2 -p 205 -st topic35_1_1 -pt None -u 0.014571563489573058 > ./result_6chains/node35_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_2 -p 332 -st topic35_2_1 -pt None -u 0.1272781487906872 > ./result_6chains/node35_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_2 -p 448 -st topic35_3_1 -pt None -u 0.049353881252778176 > ./result_6chains/node35_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_2 -p 793 -st topic35_4_1 -pt None -u 0.005758785143326631 > ./result_6chains/node35_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_2 -p 799 -st topic35_5_1 -pt None -u 0.0006758173188060162 > ./result_6chains/node35_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_0 -p 82 -st none -pt topic35_0_0 -u 0.01072403834553115 > ./result_6chains/node35_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_0 -p 205 -st none -pt topic35_1_0 -u 0.00024397690522293125 > ./result_6chains/node35_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_0 -p 332 -st none -pt topic35_2_0 -u 0.014111211088055298 > ./result_6chains/node35_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_0 -p 448 -st none -pt topic35_3_0 -u 0.027342651074723084 > ./result_6chains/node35_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_0 -p 793 -st none -pt topic35_4_0 -u 0.04682657457143424 > ./result_6chains/node35_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_0 -p 799 -st none -pt topic35_5_0 -u 0.030963862919940667 > ./result_6chains/node35_5_0.txt &
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
    "./result_6chains/node35_0_0.txt 90"
    "./result_6chains/node35_0_2.txt 90"
    "./result_6chains/node35_1_0.txt 89"
    "./result_6chains/node35_1_2.txt 89"
    "./result_6chains/node35_2_0.txt 88"
    "./result_6chains/node35_2_2.txt 88"
    "./result_6chains/node35_3_0.txt 87"
    "./result_6chains/node35_3_2.txt 87"
    "./result_6chains/node35_4_0.txt 86"
    "./result_6chains/node35_4_2.txt 86"
    "./result_6chains/node35_5_0.txt 85"
    "./result_6chains/node35_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
