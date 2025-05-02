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
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_2 -p 19 -st topic326_0_1 -pt None -u 0.0014879802403827136 > ./result_8chains/node326_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_2 -p 526 -st topic326_1_1 -pt None -u 0.001647169826829109 > ./result_8chains/node326_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_2 -p 572 -st topic326_2_1 -pt None -u 0.015249503870877368 > ./result_8chains/node326_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_2 -p 600 -st topic326_3_1 -pt None -u 0.0023548391980932615 > ./result_8chains/node326_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_2 -p 638 -st topic326_4_1 -pt None -u 0.019628959562161097 > ./result_8chains/node326_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_2 -p 869 -st topic326_5_1 -pt None -u 0.07305287575303285 > ./result_8chains/node326_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_2 -p 892 -st topic326_6_1 -pt None -u 0.013497107231932037 > ./result_8chains/node326_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_2 -p 899 -st topic326_7_1 -pt None -u 0.01863412359485186 > ./result_8chains/node326_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_0 -p 19 -st none -pt topic326_0_0 -u 0.006898530463568586 > ./result_8chains/node326_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_0 -p 526 -st none -pt topic326_1_0 -u 0.03824737258049682 > ./result_8chains/node326_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_0 -p 572 -st none -pt topic326_2_0 -u 0.03898962632678127 > ./result_8chains/node326_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_0 -p 600 -st none -pt topic326_3_0 -u 0.04153475189671585 > ./result_8chains/node326_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_0 -p 638 -st none -pt topic326_4_0 -u 0.027050126087332316 > ./result_8chains/node326_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_0 -p 869 -st none -pt topic326_5_0 -u 0.00878444720560606 > ./result_8chains/node326_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_0 -p 892 -st none -pt topic326_6_0 -u 0.08522623585800465 > ./result_8chains/node326_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_0 -p 899 -st none -pt topic326_7_0 -u 0.04638742529446191 > ./result_8chains/node326_7_0.txt &
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
    "./result_8chains/node326_0_0.txt 90"
    "./result_8chains/node326_0_2.txt 90"
    "./result_8chains/node326_1_0.txt 89"
    "./result_8chains/node326_1_2.txt 89"
    "./result_8chains/node326_2_0.txt 88"
    "./result_8chains/node326_2_2.txt 88"
    "./result_8chains/node326_3_0.txt 87"
    "./result_8chains/node326_3_2.txt 87"
    "./result_8chains/node326_4_0.txt 86"
    "./result_8chains/node326_4_2.txt 86"
    "./result_8chains/node326_5_0.txt 85"
    "./result_8chains/node326_5_2.txt 85"
    "./result_8chains/node326_6_0.txt 84"
    "./result_8chains/node326_6_2.txt 84"
    "./result_8chains/node326_7_0.txt 83"
    "./result_8chains/node326_7_2.txt 83"
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
