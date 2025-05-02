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
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_2 -p 11 -st topic95_0_1 -pt None -u 0.012538683350369006 > ./result_8chains/node95_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_2 -p 13 -st topic95_1_1 -pt None -u 0.011338947992824422 > ./result_8chains/node95_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_2 -p 26 -st topic95_2_1 -pt None -u 0.025603872127560934 > ./result_8chains/node95_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_2 -p 97 -st topic95_3_1 -pt None -u 0.016849083126168868 > ./result_8chains/node95_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_2 -p 147 -st topic95_4_1 -pt None -u 0.021615042829931846 > ./result_8chains/node95_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_2 -p 466 -st topic95_5_1 -pt None -u 0.012488240091466804 > ./result_8chains/node95_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_2 -p 778 -st topic95_6_1 -pt None -u 0.0035112204093853475 > ./result_8chains/node95_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_2 -p 908 -st topic95_7_1 -pt None -u 0.015077960613376934 > ./result_8chains/node95_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_0 -p 11 -st none -pt topic95_0_0 -u 0.01762003786181804 > ./result_8chains/node95_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_0 -p 13 -st none -pt topic95_1_0 -u 0.030221505117397962 > ./result_8chains/node95_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_0 -p 26 -st none -pt topic95_2_0 -u 0.031779515231142474 > ./result_8chains/node95_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_0 -p 97 -st none -pt topic95_3_0 -u 0.009473010425187889 > ./result_8chains/node95_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_0 -p 147 -st none -pt topic95_4_0 -u 0.07775244386000388 > ./result_8chains/node95_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_0 -p 466 -st none -pt topic95_5_0 -u 0.032787003840978914 > ./result_8chains/node95_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_0 -p 778 -st none -pt topic95_6_0 -u 0.005816979515319176 > ./result_8chains/node95_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_0 -p 908 -st none -pt topic95_7_0 -u 0.0010573515110321174 > ./result_8chains/node95_7_0.txt &
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
    "./result_8chains/node95_0_0.txt 90"
    "./result_8chains/node95_0_2.txt 90"
    "./result_8chains/node95_1_0.txt 89"
    "./result_8chains/node95_1_2.txt 89"
    "./result_8chains/node95_2_0.txt 88"
    "./result_8chains/node95_2_2.txt 88"
    "./result_8chains/node95_3_0.txt 87"
    "./result_8chains/node95_3_2.txt 87"
    "./result_8chains/node95_4_0.txt 86"
    "./result_8chains/node95_4_2.txt 86"
    "./result_8chains/node95_5_0.txt 85"
    "./result_8chains/node95_5_2.txt 85"
    "./result_8chains/node95_6_0.txt 84"
    "./result_8chains/node95_6_2.txt 84"
    "./result_8chains/node95_7_0.txt 83"
    "./result_8chains/node95_7_2.txt 83"
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
