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
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_2 -p 59 -st topic125_0_1 -pt None -u 0.03672830204537514 > ./result_8chains/node125_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_2 -p 207 -st topic125_1_1 -pt None -u 0.014930776460340911 > ./result_8chains/node125_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_2 -p 318 -st topic125_2_1 -pt None -u 0.007543891641462908 > ./result_8chains/node125_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_2 -p 446 -st topic125_3_1 -pt None -u 0.010419903331033875 > ./result_8chains/node125_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_2 -p 604 -st topic125_4_1 -pt None -u 0.0075855671866598695 > ./result_8chains/node125_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_2 -p 617 -st topic125_5_1 -pt None -u 0.019105172204312793 > ./result_8chains/node125_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_6_2 -p 921 -st topic125_6_1 -pt None -u 0.002822497325018977 > ./result_8chains/node125_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_7_2 -p 997 -st topic125_7_1 -pt None -u 0.02470699030364456 > ./result_8chains/node125_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_0 -p 59 -st none -pt topic125_0_0 -u 0.04369903939975589 > ./result_8chains/node125_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_0 -p 207 -st none -pt topic125_1_0 -u 0.04436023571633063 > ./result_8chains/node125_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_0 -p 318 -st none -pt topic125_2_0 -u 0.0042045847769099365 > ./result_8chains/node125_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_0 -p 446 -st none -pt topic125_3_0 -u 0.010367893071890566 > ./result_8chains/node125_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_0 -p 604 -st none -pt topic125_4_0 -u 0.010239930298584887 > ./result_8chains/node125_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_0 -p 617 -st none -pt topic125_5_0 -u 0.012648485370142876 > ./result_8chains/node125_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_6_0 -p 921 -st none -pt topic125_6_0 -u 0.033072322795678566 > ./result_8chains/node125_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_7_0 -p 997 -st none -pt topic125_7_0 -u 0.027715183041825027 > ./result_8chains/node125_7_0.txt &
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
    "./result_8chains/node125_0_0.txt 90"
    "./result_8chains/node125_0_2.txt 90"
    "./result_8chains/node125_1_0.txt 89"
    "./result_8chains/node125_1_2.txt 89"
    "./result_8chains/node125_2_0.txt 88"
    "./result_8chains/node125_2_2.txt 88"
    "./result_8chains/node125_3_0.txt 87"
    "./result_8chains/node125_3_2.txt 87"
    "./result_8chains/node125_4_0.txt 86"
    "./result_8chains/node125_4_2.txt 86"
    "./result_8chains/node125_5_0.txt 85"
    "./result_8chains/node125_5_2.txt 85"
    "./result_8chains/node125_6_0.txt 84"
    "./result_8chains/node125_6_2.txt 84"
    "./result_8chains/node125_7_0.txt 83"
    "./result_8chains/node125_7_2.txt 83"
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
