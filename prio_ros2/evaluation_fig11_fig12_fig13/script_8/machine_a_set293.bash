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
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_2 -p 354 -st topic293_0_1 -pt None -u 0.050621137353074275 > ./result_8chains/node293_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_2 -p 521 -st topic293_1_1 -pt None -u 0.0019456239303607403 > ./result_8chains/node293_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_2 -p 558 -st topic293_2_1 -pt None -u 0.0013711729154423091 > ./result_8chains/node293_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_2 -p 626 -st topic293_3_1 -pt None -u 0.007045215450336928 > ./result_8chains/node293_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_2 -p 646 -st topic293_4_1 -pt None -u 0.006340645823564389 > ./result_8chains/node293_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_2 -p 651 -st topic293_5_1 -pt None -u 0.07203654898698103 > ./result_8chains/node293_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_2 -p 698 -st topic293_6_1 -pt None -u 0.012473132333231884 > ./result_8chains/node293_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_2 -p 801 -st topic293_7_1 -pt None -u 0.042461075142338864 > ./result_8chains/node293_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_0 -p 354 -st none -pt topic293_0_0 -u 0.00371639024310233 > ./result_8chains/node293_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_0 -p 521 -st none -pt topic293_1_0 -u 0.03082579755461068 > ./result_8chains/node293_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_0 -p 558 -st none -pt topic293_2_0 -u 0.006426123479279899 > ./result_8chains/node293_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_0 -p 626 -st none -pt topic293_3_0 -u 0.030811090231568528 > ./result_8chains/node293_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_0 -p 646 -st none -pt topic293_4_0 -u 0.018282629098768544 > ./result_8chains/node293_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_0 -p 651 -st none -pt topic293_5_0 -u 0.0015025347110287635 > ./result_8chains/node293_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_0 -p 698 -st none -pt topic293_6_0 -u 0.024175410584004534 > ./result_8chains/node293_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_0 -p 801 -st none -pt topic293_7_0 -u 0.0017676463728128339 > ./result_8chains/node293_7_0.txt &
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
    "./result_8chains/node293_0_0.txt 90"
    "./result_8chains/node293_0_2.txt 90"
    "./result_8chains/node293_1_0.txt 89"
    "./result_8chains/node293_1_2.txt 89"
    "./result_8chains/node293_2_0.txt 88"
    "./result_8chains/node293_2_2.txt 88"
    "./result_8chains/node293_3_0.txt 87"
    "./result_8chains/node293_3_2.txt 87"
    "./result_8chains/node293_4_0.txt 86"
    "./result_8chains/node293_4_2.txt 86"
    "./result_8chains/node293_5_0.txt 85"
    "./result_8chains/node293_5_2.txt 85"
    "./result_8chains/node293_6_0.txt 84"
    "./result_8chains/node293_6_2.txt 84"
    "./result_8chains/node293_7_0.txt 83"
    "./result_8chains/node293_7_2.txt 83"
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
