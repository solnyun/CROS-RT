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
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_2 -p 19 -st topic150_0_1 -pt None -u 0.0400017838093325 > ./result_8chains/node150_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_2 -p 168 -st topic150_1_1 -pt None -u 0.013676947451344956 > ./result_8chains/node150_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_2 -p 255 -st topic150_2_1 -pt None -u 0.04627894028148627 > ./result_8chains/node150_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_2 -p 377 -st topic150_3_1 -pt None -u 0.006880122876492811 > ./result_8chains/node150_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_2 -p 506 -st topic150_4_1 -pt None -u 0.020532817996757935 > ./result_8chains/node150_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_2 -p 537 -st topic150_5_1 -pt None -u 0.03888264038573021 > ./result_8chains/node150_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_6_2 -p 644 -st topic150_6_1 -pt None -u 0.00940543606568385 > ./result_8chains/node150_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_7_2 -p 923 -st topic150_7_1 -pt None -u 0.006135515353016536 > ./result_8chains/node150_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_0 -p 19 -st none -pt topic150_0_0 -u 0.0009809119789475074 > ./result_8chains/node150_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_0 -p 168 -st none -pt topic150_1_0 -u 0.0006315908311114171 > ./result_8chains/node150_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_0 -p 255 -st none -pt topic150_2_0 -u 0.0022479920818115895 > ./result_8chains/node150_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_0 -p 377 -st none -pt topic150_3_0 -u 0.02208586488109765 > ./result_8chains/node150_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_0 -p 506 -st none -pt topic150_4_0 -u 0.01411439145953089 > ./result_8chains/node150_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_0 -p 537 -st none -pt topic150_5_0 -u 0.008590129544565422 > ./result_8chains/node150_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_6_0 -p 644 -st none -pt topic150_6_0 -u 0.014458487306292511 > ./result_8chains/node150_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_7_0 -p 923 -st none -pt topic150_7_0 -u 0.007083004963937885 > ./result_8chains/node150_7_0.txt &
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
    "./result_8chains/node150_0_0.txt 90"
    "./result_8chains/node150_0_2.txt 90"
    "./result_8chains/node150_1_0.txt 89"
    "./result_8chains/node150_1_2.txt 89"
    "./result_8chains/node150_2_0.txt 88"
    "./result_8chains/node150_2_2.txt 88"
    "./result_8chains/node150_3_0.txt 87"
    "./result_8chains/node150_3_2.txt 87"
    "./result_8chains/node150_4_0.txt 86"
    "./result_8chains/node150_4_2.txt 86"
    "./result_8chains/node150_5_0.txt 85"
    "./result_8chains/node150_5_2.txt 85"
    "./result_8chains/node150_6_0.txt 84"
    "./result_8chains/node150_6_2.txt 84"
    "./result_8chains/node150_7_0.txt 83"
    "./result_8chains/node150_7_2.txt 83"
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
