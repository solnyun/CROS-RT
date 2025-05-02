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
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_2 -p 31 -st topic56_0_1 -pt None -u 0.007377135657757661 > ./result_8chains/node56_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_2 -p 518 -st topic56_1_1 -pt None -u 0.02188638321858921 > ./result_8chains/node56_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_2 -p 520 -st topic56_2_1 -pt None -u 0.022991605518904668 > ./result_8chains/node56_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_2 -p 536 -st topic56_3_1 -pt None -u 0.020140787377874808 > ./result_8chains/node56_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_2 -p 563 -st topic56_4_1 -pt None -u 0.010106941696194444 > ./result_8chains/node56_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_2 -p 612 -st topic56_5_1 -pt None -u 0.04822785838326886 > ./result_8chains/node56_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_6_2 -p 857 -st topic56_6_1 -pt None -u 0.0011079529634786256 > ./result_8chains/node56_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_7_2 -p 882 -st topic56_7_1 -pt None -u 0.008399656311548221 > ./result_8chains/node56_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_0 -p 31 -st none -pt topic56_0_0 -u 0.04606731999834951 > ./result_8chains/node56_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_0 -p 518 -st none -pt topic56_1_0 -u 0.018288894548845636 > ./result_8chains/node56_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_0 -p 520 -st none -pt topic56_2_0 -u 0.004384183460980795 > ./result_8chains/node56_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_0 -p 536 -st none -pt topic56_3_0 -u 0.03687581616465613 > ./result_8chains/node56_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_0 -p 563 -st none -pt topic56_4_0 -u 0.00039145306958288106 > ./result_8chains/node56_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_0 -p 612 -st none -pt topic56_5_0 -u 0.01045135422822216 > ./result_8chains/node56_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_6_0 -p 857 -st none -pt topic56_6_0 -u 0.006891199224459937 > ./result_8chains/node56_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_7_0 -p 882 -st none -pt topic56_7_0 -u 0.004864808627248144 > ./result_8chains/node56_7_0.txt &
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
    "./result_8chains/node56_0_0.txt 90"
    "./result_8chains/node56_0_2.txt 90"
    "./result_8chains/node56_1_0.txt 89"
    "./result_8chains/node56_1_2.txt 89"
    "./result_8chains/node56_2_0.txt 88"
    "./result_8chains/node56_2_2.txt 88"
    "./result_8chains/node56_3_0.txt 87"
    "./result_8chains/node56_3_2.txt 87"
    "./result_8chains/node56_4_0.txt 86"
    "./result_8chains/node56_4_2.txt 86"
    "./result_8chains/node56_5_0.txt 85"
    "./result_8chains/node56_5_2.txt 85"
    "./result_8chains/node56_6_0.txt 84"
    "./result_8chains/node56_6_2.txt 84"
    "./result_8chains/node56_7_0.txt 83"
    "./result_8chains/node56_7_2.txt 83"
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
