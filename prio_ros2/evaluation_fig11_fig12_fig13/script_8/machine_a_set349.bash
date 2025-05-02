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
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_2 -p 370 -st topic349_0_1 -pt None -u 0.006029028680608006 > ./result_8chains/node349_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_2 -p 512 -st topic349_1_1 -pt None -u 0.04664303197309555 > ./result_8chains/node349_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_2 -p 641 -st topic349_2_1 -pt None -u 0.021570122218468435 > ./result_8chains/node349_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_2 -p 658 -st topic349_3_1 -pt None -u 0.001961421327192514 > ./result_8chains/node349_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_2 -p 749 -st topic349_4_1 -pt None -u 0.06329955968868017 > ./result_8chains/node349_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_2 -p 779 -st topic349_5_1 -pt None -u 0.007311344920076582 > ./result_8chains/node349_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_2 -p 834 -st topic349_6_1 -pt None -u 0.014032262195775975 > ./result_8chains/node349_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_2 -p 921 -st topic349_7_1 -pt None -u 0.008046323105259157 > ./result_8chains/node349_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_0_0 -p 370 -st none -pt topic349_0_0 -u 0.00549697841108987 > ./result_8chains/node349_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_1_0 -p 512 -st none -pt topic349_1_0 -u 0.04868427130988506 > ./result_8chains/node349_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_2_0 -p 641 -st none -pt topic349_2_0 -u 0.007154202373684859 > ./result_8chains/node349_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_3_0 -p 658 -st none -pt topic349_3_0 -u 0.022166284804045255 > ./result_8chains/node349_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_4_0 -p 749 -st none -pt topic349_4_0 -u 0.03625977891310514 > ./result_8chains/node349_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_5_0 -p 779 -st none -pt topic349_5_0 -u 0.025874720058427836 > ./result_8chains/node349_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node349_6_0 -p 834 -st none -pt topic349_6_0 -u 0.005703759469440642 > ./result_8chains/node349_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node349_7_0 -p 921 -st none -pt topic349_7_0 -u 0.025831465594832733 > ./result_8chains/node349_7_0.txt &
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
    "./result_8chains/node349_0_0.txt 90"
    "./result_8chains/node349_0_2.txt 90"
    "./result_8chains/node349_1_0.txt 89"
    "./result_8chains/node349_1_2.txt 89"
    "./result_8chains/node349_2_0.txt 88"
    "./result_8chains/node349_2_2.txt 88"
    "./result_8chains/node349_3_0.txt 87"
    "./result_8chains/node349_3_2.txt 87"
    "./result_8chains/node349_4_0.txt 86"
    "./result_8chains/node349_4_2.txt 86"
    "./result_8chains/node349_5_0.txt 85"
    "./result_8chains/node349_5_2.txt 85"
    "./result_8chains/node349_6_0.txt 84"
    "./result_8chains/node349_6_2.txt 84"
    "./result_8chains/node349_7_0.txt 83"
    "./result_8chains/node349_7_2.txt 83"
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
