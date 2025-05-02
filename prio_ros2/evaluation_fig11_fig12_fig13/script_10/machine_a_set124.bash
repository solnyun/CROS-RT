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
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_2 -p 123 -st topic124_0_1 -pt None -u 0.014239493950953086 > ./result_10chains/node124_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_2 -p 158 -st topic124_1_1 -pt None -u 0.002969390522925053 > ./result_10chains/node124_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_2 -p 187 -st topic124_2_1 -pt None -u 0.03535594400980696 > ./result_10chains/node124_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_2 -p 231 -st topic124_3_1 -pt None -u 0.016839085781833185 > ./result_10chains/node124_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_2 -p 626 -st topic124_4_1 -pt None -u 0.036286424952401475 > ./result_10chains/node124_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_2 -p 654 -st topic124_5_1 -pt None -u 0.0121898066279221 > ./result_10chains/node124_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_2 -p 705 -st topic124_6_1 -pt None -u 0.001615569386850979 > ./result_10chains/node124_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_2 -p 774 -st topic124_7_1 -pt None -u 0.00991617301086134 > ./result_10chains/node124_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_8_2 -p 961 -st topic124_8_1 -pt None -u 0.035173314969340154 > ./result_10chains/node124_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_9_2 -p 997 -st topic124_9_1 -pt None -u 0.03608618585712001 > ./result_10chains/node124_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_0 -p 123 -st none -pt topic124_0_0 -u 0.013863077127492407 > ./result_10chains/node124_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_0 -p 158 -st none -pt topic124_1_0 -u 0.006709885696186968 > ./result_10chains/node124_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_0 -p 187 -st none -pt topic124_2_0 -u 0.014407001894218951 > ./result_10chains/node124_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_0 -p 231 -st none -pt topic124_3_0 -u 0.013238119025180739 > ./result_10chains/node124_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_0 -p 626 -st none -pt topic124_4_0 -u 0.008339307528286932 > ./result_10chains/node124_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_0 -p 654 -st none -pt topic124_5_0 -u 0.00025261246892768763 > ./result_10chains/node124_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_0 -p 705 -st none -pt topic124_6_0 -u 0.014141041766934787 > ./result_10chains/node124_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_0 -p 774 -st none -pt topic124_7_0 -u 0.006739121770072465 > ./result_10chains/node124_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_8_0 -p 961 -st none -pt topic124_8_0 -u 0.0017667476786680375 > ./result_10chains/node124_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_9_0 -p 997 -st none -pt topic124_9_0 -u 0.0034713734733564927 > ./result_10chains/node124_9_0.txt &
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
    "./result_10chains/node124_0_0.txt 90"
    "./result_10chains/node124_0_2.txt 90"
    "./result_10chains/node124_1_0.txt 89"
    "./result_10chains/node124_1_2.txt 89"
    "./result_10chains/node124_2_0.txt 88"
    "./result_10chains/node124_2_2.txt 88"
    "./result_10chains/node124_3_0.txt 87"
    "./result_10chains/node124_3_2.txt 87"
    "./result_10chains/node124_4_0.txt 86"
    "./result_10chains/node124_4_2.txt 86"
    "./result_10chains/node124_5_0.txt 85"
    "./result_10chains/node124_5_2.txt 85"
    "./result_10chains/node124_6_0.txt 84"
    "./result_10chains/node124_6_2.txt 84"
    "./result_10chains/node124_7_0.txt 83"
    "./result_10chains/node124_7_2.txt 83"
    "./result_10chains/node124_8_0.txt 82"
    "./result_10chains/node124_8_2.txt 82"
    "./result_10chains/node124_9_0.txt 81"
    "./result_10chains/node124_9_2.txt 81"
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
