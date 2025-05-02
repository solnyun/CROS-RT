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
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_2 -p 50 -st topic14_0_1 -pt None -u 0.08312591194417845 > ./result_8chains/node14_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_2 -p 361 -st topic14_1_1 -pt None -u 0.013285125865338754 > ./result_8chains/node14_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_2 -p 465 -st topic14_2_1 -pt None -u 0.006077972425859057 > ./result_8chains/node14_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_2 -p 574 -st topic14_3_1 -pt None -u 0.006098648652258926 > ./result_8chains/node14_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_2 -p 639 -st topic14_4_1 -pt None -u 0.013463659563121039 > ./result_8chains/node14_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_2 -p 646 -st topic14_5_1 -pt None -u 0.002673710590582079 > ./result_8chains/node14_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_6_2 -p 741 -st topic14_6_1 -pt None -u 0.010138021940491335 > ./result_8chains/node14_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_7_2 -p 744 -st topic14_7_1 -pt None -u 0.023391471272530964 > ./result_8chains/node14_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_0 -p 50 -st none -pt topic14_0_0 -u 0.003633122355014673 > ./result_8chains/node14_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_0 -p 361 -st none -pt topic14_1_0 -u 0.019826496184852216 > ./result_8chains/node14_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_0 -p 465 -st none -pt topic14_2_0 -u 0.008882913392252834 > ./result_8chains/node14_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_0 -p 574 -st none -pt topic14_3_0 -u 9.261171540581037e-05 > ./result_8chains/node14_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_0 -p 639 -st none -pt topic14_4_0 -u 0.007688514435232607 > ./result_8chains/node14_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_0 -p 646 -st none -pt topic14_5_0 -u 0.04324284501555814 > ./result_8chains/node14_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_6_0 -p 741 -st none -pt topic14_6_0 -u 0.02936030340475715 > ./result_8chains/node14_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_7_0 -p 744 -st none -pt topic14_7_0 -u 0.0003213817370196423 > ./result_8chains/node14_7_0.txt &
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
    "./result_8chains/node14_0_0.txt 90"
    "./result_8chains/node14_0_2.txt 90"
    "./result_8chains/node14_1_0.txt 89"
    "./result_8chains/node14_1_2.txt 89"
    "./result_8chains/node14_2_0.txt 88"
    "./result_8chains/node14_2_2.txt 88"
    "./result_8chains/node14_3_0.txt 87"
    "./result_8chains/node14_3_2.txt 87"
    "./result_8chains/node14_4_0.txt 86"
    "./result_8chains/node14_4_2.txt 86"
    "./result_8chains/node14_5_0.txt 85"
    "./result_8chains/node14_5_2.txt 85"
    "./result_8chains/node14_6_0.txt 84"
    "./result_8chains/node14_6_2.txt 84"
    "./result_8chains/node14_7_0.txt 83"
    "./result_8chains/node14_7_2.txt 83"
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
