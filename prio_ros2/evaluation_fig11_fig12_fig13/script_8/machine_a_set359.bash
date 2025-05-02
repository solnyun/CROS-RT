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
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_2 -p 91 -st topic359_0_1 -pt None -u 0.010786405790269016 > ./result_8chains/node359_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_2 -p 150 -st topic359_1_1 -pt None -u 0.004251057013556103 > ./result_8chains/node359_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_2 -p 212 -st topic359_2_1 -pt None -u 0.028248727372905957 > ./result_8chains/node359_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_2 -p 393 -st topic359_3_1 -pt None -u 0.02730268405899358 > ./result_8chains/node359_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_2 -p 594 -st topic359_4_1 -pt None -u 0.0017907427105348928 > ./result_8chains/node359_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_2 -p 729 -st topic359_5_1 -pt None -u 0.02713723240124269 > ./result_8chains/node359_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_6_2 -p 752 -st topic359_6_1 -pt None -u 0.007168142285161695 > ./result_8chains/node359_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_7_2 -p 949 -st topic359_7_1 -pt None -u 0.035702432722971064 > ./result_8chains/node359_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_0 -p 91 -st none -pt topic359_0_0 -u 0.021113956473022943 > ./result_8chains/node359_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_0 -p 150 -st none -pt topic359_1_0 -u 0.0520862131222371 > ./result_8chains/node359_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_0 -p 212 -st none -pt topic359_2_0 -u 0.025489889347464656 > ./result_8chains/node359_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_0 -p 393 -st none -pt topic359_3_0 -u 0.01808947618678103 > ./result_8chains/node359_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_0 -p 594 -st none -pt topic359_4_0 -u 0.0031117497507867076 > ./result_8chains/node359_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_0 -p 729 -st none -pt topic359_5_0 -u 0.049191223446279436 > ./result_8chains/node359_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_6_0 -p 752 -st none -pt topic359_6_0 -u 0.019589875354667288 > ./result_8chains/node359_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_7_0 -p 949 -st none -pt topic359_7_0 -u 0.007041566307303973 > ./result_8chains/node359_7_0.txt &
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
    "./result_8chains/node359_0_0.txt 90"
    "./result_8chains/node359_0_2.txt 90"
    "./result_8chains/node359_1_0.txt 89"
    "./result_8chains/node359_1_2.txt 89"
    "./result_8chains/node359_2_0.txt 88"
    "./result_8chains/node359_2_2.txt 88"
    "./result_8chains/node359_3_0.txt 87"
    "./result_8chains/node359_3_2.txt 87"
    "./result_8chains/node359_4_0.txt 86"
    "./result_8chains/node359_4_2.txt 86"
    "./result_8chains/node359_5_0.txt 85"
    "./result_8chains/node359_5_2.txt 85"
    "./result_8chains/node359_6_0.txt 84"
    "./result_8chains/node359_6_2.txt 84"
    "./result_8chains/node359_7_0.txt 83"
    "./result_8chains/node359_7_2.txt 83"
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
