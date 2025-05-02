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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_2 -p 13 -st topic68_0_1 -pt None -u 0.016575493313482625 > ./result_8chains/node68_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_2 -p 41 -st topic68_1_1 -pt None -u 0.037118047898155204 > ./result_8chains/node68_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_2 -p 256 -st topic68_2_1 -pt None -u 0.011698684667995451 > ./result_8chains/node68_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_2 -p 381 -st topic68_3_1 -pt None -u 0.01429448443751044 > ./result_8chains/node68_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_2 -p 550 -st topic68_4_1 -pt None -u 0.06646181882096086 > ./result_8chains/node68_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_2 -p 568 -st topic68_5_1 -pt None -u 0.0004418091999446039 > ./result_8chains/node68_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_6_2 -p 569 -st topic68_6_1 -pt None -u 0.009535182230004505 > ./result_8chains/node68_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_7_2 -p 584 -st topic68_7_1 -pt None -u 0.039774344169837536 > ./result_8chains/node68_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_0 -p 13 -st none -pt topic68_0_0 -u 0.03215427732473913 > ./result_8chains/node68_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_0 -p 41 -st none -pt topic68_1_0 -u 0.06368444161236647 > ./result_8chains/node68_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_0 -p 256 -st none -pt topic68_2_0 -u 0.0412707429534408 > ./result_8chains/node68_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_0 -p 381 -st none -pt topic68_3_0 -u 0.03933810146313227 > ./result_8chains/node68_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_0 -p 550 -st none -pt topic68_4_0 -u 0.002782547902300675 > ./result_8chains/node68_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_0 -p 568 -st none -pt topic68_5_0 -u 0.0049568840758701105 > ./result_8chains/node68_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_6_0 -p 569 -st none -pt topic68_6_0 -u 0.0019765696561420826 > ./result_8chains/node68_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_7_0 -p 584 -st none -pt topic68_7_0 -u 0.010745372114763327 > ./result_8chains/node68_7_0.txt &
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
    "./result_8chains/node68_0_0.txt 90"
    "./result_8chains/node68_0_2.txt 90"
    "./result_8chains/node68_1_0.txt 89"
    "./result_8chains/node68_1_2.txt 89"
    "./result_8chains/node68_2_0.txt 88"
    "./result_8chains/node68_2_2.txt 88"
    "./result_8chains/node68_3_0.txt 87"
    "./result_8chains/node68_3_2.txt 87"
    "./result_8chains/node68_4_0.txt 86"
    "./result_8chains/node68_4_2.txt 86"
    "./result_8chains/node68_5_0.txt 85"
    "./result_8chains/node68_5_2.txt 85"
    "./result_8chains/node68_6_0.txt 84"
    "./result_8chains/node68_6_2.txt 84"
    "./result_8chains/node68_7_0.txt 83"
    "./result_8chains/node68_7_2.txt 83"
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
