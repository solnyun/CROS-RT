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
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_2 -p 377 -st topic215_0_1 -pt None -u 0.0032657954207464535 > ./result_8chains/node215_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_2 -p 447 -st topic215_1_1 -pt None -u 0.008485644470109854 > ./result_8chains/node215_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_2 -p 551 -st topic215_2_1 -pt None -u 0.007624420731450643 > ./result_8chains/node215_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_2 -p 635 -st topic215_3_1 -pt None -u 0.0398436228871564 > ./result_8chains/node215_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_2 -p 730 -st topic215_4_1 -pt None -u 0.005075808707668189 > ./result_8chains/node215_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_2 -p 808 -st topic215_5_1 -pt None -u 0.024350438513072725 > ./result_8chains/node215_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_6_2 -p 852 -st topic215_6_1 -pt None -u 0.00829468785440099 > ./result_8chains/node215_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_7_2 -p 986 -st topic215_7_1 -pt None -u 0.06268200037252986 > ./result_8chains/node215_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_0 -p 377 -st none -pt topic215_0_0 -u 0.048534624420322914 > ./result_8chains/node215_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_0 -p 447 -st none -pt topic215_1_0 -u 0.041473111754981196 > ./result_8chains/node215_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_0 -p 551 -st none -pt topic215_2_0 -u 0.09445242287925593 > ./result_8chains/node215_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_0 -p 635 -st none -pt topic215_3_0 -u 0.012735144011791488 > ./result_8chains/node215_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_0 -p 730 -st none -pt topic215_4_0 -u 0.010075000109767307 > ./result_8chains/node215_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_0 -p 808 -st none -pt topic215_5_0 -u 0.00556000169465562 > ./result_8chains/node215_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_6_0 -p 852 -st none -pt topic215_6_0 -u 0.014738192740086892 > ./result_8chains/node215_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_7_0 -p 986 -st none -pt topic215_7_0 -u 0.00440869393228098 > ./result_8chains/node215_7_0.txt &
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
    "./result_8chains/node215_0_0.txt 90"
    "./result_8chains/node215_0_2.txt 90"
    "./result_8chains/node215_1_0.txt 89"
    "./result_8chains/node215_1_2.txt 89"
    "./result_8chains/node215_2_0.txt 88"
    "./result_8chains/node215_2_2.txt 88"
    "./result_8chains/node215_3_0.txt 87"
    "./result_8chains/node215_3_2.txt 87"
    "./result_8chains/node215_4_0.txt 86"
    "./result_8chains/node215_4_2.txt 86"
    "./result_8chains/node215_5_0.txt 85"
    "./result_8chains/node215_5_2.txt 85"
    "./result_8chains/node215_6_0.txt 84"
    "./result_8chains/node215_6_2.txt 84"
    "./result_8chains/node215_7_0.txt 83"
    "./result_8chains/node215_7_2.txt 83"
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
