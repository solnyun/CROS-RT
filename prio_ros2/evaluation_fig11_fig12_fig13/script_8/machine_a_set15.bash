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
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_2 -p 314 -st topic15_0_1 -pt None -u 0.0029299611780022605 > ./result_8chains/node15_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_2 -p 371 -st topic15_1_1 -pt None -u 0.008177093311832306 > ./result_8chains/node15_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_2 -p 504 -st topic15_2_1 -pt None -u 0.019233093360556897 > ./result_8chains/node15_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_2 -p 604 -st topic15_3_1 -pt None -u 0.00951862154707589 > ./result_8chains/node15_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_2 -p 726 -st topic15_4_1 -pt None -u 0.01911155222145794 > ./result_8chains/node15_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_2 -p 850 -st topic15_5_1 -pt None -u 0.025584883696385563 > ./result_8chains/node15_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_6_2 -p 901 -st topic15_6_1 -pt None -u 0.013179938856439338 > ./result_8chains/node15_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_7_2 -p 952 -st topic15_7_1 -pt None -u 0.030242450357470762 > ./result_8chains/node15_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_0 -p 314 -st none -pt topic15_0_0 -u 0.04535046433123613 > ./result_8chains/node15_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_0 -p 371 -st none -pt topic15_1_0 -u 0.003321189544815195 > ./result_8chains/node15_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_0 -p 504 -st none -pt topic15_2_0 -u 0.016786699639453118 > ./result_8chains/node15_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_0 -p 604 -st none -pt topic15_3_0 -u 0.008067252987296186 > ./result_8chains/node15_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_0 -p 726 -st none -pt topic15_4_0 -u 0.0066565208127968845 > ./result_8chains/node15_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_0 -p 850 -st none -pt topic15_5_0 -u 0.010467714139851508 > ./result_8chains/node15_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_6_0 -p 901 -st none -pt topic15_6_0 -u 0.009673883452704299 > ./result_8chains/node15_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_7_0 -p 952 -st none -pt topic15_7_0 -u 0.024172291743366582 > ./result_8chains/node15_7_0.txt &
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
    "./result_8chains/node15_0_0.txt 90"
    "./result_8chains/node15_0_2.txt 90"
    "./result_8chains/node15_1_0.txt 89"
    "./result_8chains/node15_1_2.txt 89"
    "./result_8chains/node15_2_0.txt 88"
    "./result_8chains/node15_2_2.txt 88"
    "./result_8chains/node15_3_0.txt 87"
    "./result_8chains/node15_3_2.txt 87"
    "./result_8chains/node15_4_0.txt 86"
    "./result_8chains/node15_4_2.txt 86"
    "./result_8chains/node15_5_0.txt 85"
    "./result_8chains/node15_5_2.txt 85"
    "./result_8chains/node15_6_0.txt 84"
    "./result_8chains/node15_6_2.txt 84"
    "./result_8chains/node15_7_0.txt 83"
    "./result_8chains/node15_7_2.txt 83"
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
