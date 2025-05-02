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
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_2 -p 188 -st topic325_0_1 -pt None -u 0.0022122498230900955 > ./result_8chains/node325_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_2 -p 453 -st topic325_1_1 -pt None -u 0.06372747417337737 > ./result_8chains/node325_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_2 -p 559 -st topic325_2_1 -pt None -u 0.002023582700721893 > ./result_8chains/node325_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_2 -p 871 -st topic325_3_1 -pt None -u 0.00928340615869827 > ./result_8chains/node325_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_2 -p 883 -st topic325_4_1 -pt None -u 0.00875228118100485 > ./result_8chains/node325_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_2 -p 884 -st topic325_5_1 -pt None -u 0.01233613031548221 > ./result_8chains/node325_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_6_2 -p 889 -st topic325_6_1 -pt None -u 0.005155050781861514 > ./result_8chains/node325_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_7_2 -p 982 -st topic325_7_1 -pt None -u 0.01899926792635192 > ./result_8chains/node325_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_0 -p 188 -st none -pt topic325_0_0 -u 0.0019165032516546554 > ./result_8chains/node325_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_0 -p 453 -st none -pt topic325_1_0 -u 0.032846790450214325 > ./result_8chains/node325_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_0 -p 559 -st none -pt topic325_2_0 -u 0.00036908337849178574 > ./result_8chains/node325_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_0 -p 871 -st none -pt topic325_3_0 -u 0.016570126743245706 > ./result_8chains/node325_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_0 -p 883 -st none -pt topic325_4_0 -u 0.007575570299563628 > ./result_8chains/node325_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_0 -p 884 -st none -pt topic325_5_0 -u 0.007840448799015354 > ./result_8chains/node325_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_6_0 -p 889 -st none -pt topic325_6_0 -u 0.006853795915989377 > ./result_8chains/node325_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_7_0 -p 982 -st none -pt topic325_7_0 -u 0.025884998292717114 > ./result_8chains/node325_7_0.txt &
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
    "./result_8chains/node325_0_0.txt 90"
    "./result_8chains/node325_0_2.txt 90"
    "./result_8chains/node325_1_0.txt 89"
    "./result_8chains/node325_1_2.txt 89"
    "./result_8chains/node325_2_0.txt 88"
    "./result_8chains/node325_2_2.txt 88"
    "./result_8chains/node325_3_0.txt 87"
    "./result_8chains/node325_3_2.txt 87"
    "./result_8chains/node325_4_0.txt 86"
    "./result_8chains/node325_4_2.txt 86"
    "./result_8chains/node325_5_0.txt 85"
    "./result_8chains/node325_5_2.txt 85"
    "./result_8chains/node325_6_0.txt 84"
    "./result_8chains/node325_6_2.txt 84"
    "./result_8chains/node325_7_0.txt 83"
    "./result_8chains/node325_7_2.txt 83"
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
