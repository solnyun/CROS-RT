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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_2 -p 209 -st topic383_0_1 -pt None -u 0.011779271412401815 > ./result_8chains/node383_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_2 -p 327 -st topic383_1_1 -pt None -u 0.009331149385176207 > ./result_8chains/node383_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_2 -p 333 -st topic383_2_1 -pt None -u 0.021795615203589636 > ./result_8chains/node383_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_2 -p 449 -st topic383_3_1 -pt None -u 0.010371928701189304 > ./result_8chains/node383_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_2 -p 673 -st topic383_4_1 -pt None -u 0.04476143341511818 > ./result_8chains/node383_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_2 -p 717 -st topic383_5_1 -pt None -u 0.011792160973890603 > ./result_8chains/node383_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_2 -p 735 -st topic383_6_1 -pt None -u 0.0021387927322155387 > ./result_8chains/node383_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_2 -p 927 -st topic383_7_1 -pt None -u 0.008292833414437435 > ./result_8chains/node383_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_0 -p 209 -st none -pt topic383_0_0 -u 0.021031254693704482 > ./result_8chains/node383_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_0 -p 327 -st none -pt topic383_1_0 -u 0.0058810196232751966 > ./result_8chains/node383_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_0 -p 333 -st none -pt topic383_2_0 -u 0.01274947247377678 > ./result_8chains/node383_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_0 -p 449 -st none -pt topic383_3_0 -u 0.03288661657167019 > ./result_8chains/node383_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_0 -p 673 -st none -pt topic383_4_0 -u 0.003920756413580029 > ./result_8chains/node383_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_0 -p 717 -st none -pt topic383_5_0 -u 0.07684488251639185 > ./result_8chains/node383_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_0 -p 735 -st none -pt topic383_6_0 -u 0.03361859444463604 > ./result_8chains/node383_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_0 -p 927 -st none -pt topic383_7_0 -u 0.02041017734202301 > ./result_8chains/node383_7_0.txt &
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
    "./result_8chains/node383_0_0.txt 90"
    "./result_8chains/node383_0_2.txt 90"
    "./result_8chains/node383_1_0.txt 89"
    "./result_8chains/node383_1_2.txt 89"
    "./result_8chains/node383_2_0.txt 88"
    "./result_8chains/node383_2_2.txt 88"
    "./result_8chains/node383_3_0.txt 87"
    "./result_8chains/node383_3_2.txt 87"
    "./result_8chains/node383_4_0.txt 86"
    "./result_8chains/node383_4_2.txt 86"
    "./result_8chains/node383_5_0.txt 85"
    "./result_8chains/node383_5_2.txt 85"
    "./result_8chains/node383_6_0.txt 84"
    "./result_8chains/node383_6_2.txt 84"
    "./result_8chains/node383_7_0.txt 83"
    "./result_8chains/node383_7_2.txt 83"
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
