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
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_2 -p 45 -st topic46_0_1 -pt None -u 0.04502232000407452 > ./result_8chains/node46_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_2 -p 253 -st topic46_1_1 -pt None -u 0.04178097471669645 > ./result_8chains/node46_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_2 -p 424 -st topic46_2_1 -pt None -u 0.002115528912151887 > ./result_8chains/node46_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_2 -p 484 -st topic46_3_1 -pt None -u 0.020948767350735364 > ./result_8chains/node46_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_2 -p 500 -st topic46_4_1 -pt None -u 0.011092329743545376 > ./result_8chains/node46_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_2 -p 621 -st topic46_5_1 -pt None -u 0.017600169659864023 > ./result_8chains/node46_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_6_2 -p 931 -st topic46_6_1 -pt None -u 0.003474470048753328 > ./result_8chains/node46_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_7_2 -p 961 -st topic46_7_1 -pt None -u 0.033258518577682944 > ./result_8chains/node46_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_0_0 -p 45 -st none -pt topic46_0_0 -u 0.015650675347755383 > ./result_8chains/node46_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_1_0 -p 253 -st none -pt topic46_1_0 -u 0.003558858161920586 > ./result_8chains/node46_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_2_0 -p 424 -st none -pt topic46_2_0 -u 0.0013351291004434218 > ./result_8chains/node46_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_3_0 -p 484 -st none -pt topic46_3_0 -u 0.03181308372802705 > ./result_8chains/node46_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_4_0 -p 500 -st none -pt topic46_4_0 -u 0.007512561360852876 > ./result_8chains/node46_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_5_0 -p 621 -st none -pt topic46_5_0 -u 0.005812852963006571 > ./result_8chains/node46_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node46_6_0 -p 931 -st none -pt topic46_6_0 -u 0.016621828187317444 > ./result_8chains/node46_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node46_7_0 -p 961 -st none -pt topic46_7_0 -u 0.012180780261512897 > ./result_8chains/node46_7_0.txt &
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
    "./result_8chains/node46_0_0.txt 90"
    "./result_8chains/node46_0_2.txt 90"
    "./result_8chains/node46_1_0.txt 89"
    "./result_8chains/node46_1_2.txt 89"
    "./result_8chains/node46_2_0.txt 88"
    "./result_8chains/node46_2_2.txt 88"
    "./result_8chains/node46_3_0.txt 87"
    "./result_8chains/node46_3_2.txt 87"
    "./result_8chains/node46_4_0.txt 86"
    "./result_8chains/node46_4_2.txt 86"
    "./result_8chains/node46_5_0.txt 85"
    "./result_8chains/node46_5_2.txt 85"
    "./result_8chains/node46_6_0.txt 84"
    "./result_8chains/node46_6_2.txt 84"
    "./result_8chains/node46_7_0.txt 83"
    "./result_8chains/node46_7_2.txt 83"
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
