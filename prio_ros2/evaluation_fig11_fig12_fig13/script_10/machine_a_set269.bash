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
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_2 -p 113 -st topic269_0_1 -pt None -u 0.004502490826293892 > ./result_10chains/node269_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_2 -p 134 -st topic269_1_1 -pt None -u 0.0035984006603178575 > ./result_10chains/node269_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_2 -p 171 -st topic269_2_1 -pt None -u 0.0020469932862199336 > ./result_10chains/node269_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_2 -p 187 -st topic269_3_1 -pt None -u 0.05087340381152622 > ./result_10chains/node269_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_2 -p 346 -st topic269_4_1 -pt None -u 0.0010437113433585388 > ./result_10chains/node269_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_2 -p 686 -st topic269_5_1 -pt None -u 0.006884124639171596 > ./result_10chains/node269_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_2 -p 726 -st topic269_6_1 -pt None -u 0.01075956954079832 > ./result_10chains/node269_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_2 -p 846 -st topic269_7_1 -pt None -u 0.004324285691614471 > ./result_10chains/node269_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_8_2 -p 913 -st topic269_8_1 -pt None -u 0.006272307912187379 > ./result_10chains/node269_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_9_2 -p 927 -st topic269_9_1 -pt None -u 0.037370465498443216 > ./result_10chains/node269_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_0 -p 113 -st none -pt topic269_0_0 -u 0.0027891645373772644 > ./result_10chains/node269_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_0 -p 134 -st none -pt topic269_1_0 -u 0.032513403478804825 > ./result_10chains/node269_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_0 -p 171 -st none -pt topic269_2_0 -u 0.01567561289099928 > ./result_10chains/node269_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_0 -p 187 -st none -pt topic269_3_0 -u 0.024198258276491025 > ./result_10chains/node269_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_0 -p 346 -st none -pt topic269_4_0 -u 0.019427339748123412 > ./result_10chains/node269_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_0 -p 686 -st none -pt topic269_5_0 -u 0.008193867155252721 > ./result_10chains/node269_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_0 -p 726 -st none -pt topic269_6_0 -u 0.028036572383412395 > ./result_10chains/node269_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_0 -p 846 -st none -pt topic269_7_0 -u 0.06383176816233255 > ./result_10chains/node269_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_8_0 -p 913 -st none -pt topic269_8_0 -u 0.002143466573344674 > ./result_10chains/node269_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_9_0 -p 927 -st none -pt topic269_9_0 -u 0.020384386735730634 > ./result_10chains/node269_9_0.txt &
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
    "./result_10chains/node269_0_0.txt 90"
    "./result_10chains/node269_0_2.txt 90"
    "./result_10chains/node269_1_0.txt 89"
    "./result_10chains/node269_1_2.txt 89"
    "./result_10chains/node269_2_0.txt 88"
    "./result_10chains/node269_2_2.txt 88"
    "./result_10chains/node269_3_0.txt 87"
    "./result_10chains/node269_3_2.txt 87"
    "./result_10chains/node269_4_0.txt 86"
    "./result_10chains/node269_4_2.txt 86"
    "./result_10chains/node269_5_0.txt 85"
    "./result_10chains/node269_5_2.txt 85"
    "./result_10chains/node269_6_0.txt 84"
    "./result_10chains/node269_6_2.txt 84"
    "./result_10chains/node269_7_0.txt 83"
    "./result_10chains/node269_7_2.txt 83"
    "./result_10chains/node269_8_0.txt 82"
    "./result_10chains/node269_8_2.txt 82"
    "./result_10chains/node269_9_0.txt 81"
    "./result_10chains/node269_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
