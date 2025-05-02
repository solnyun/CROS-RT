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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_2 -p 71 -st topic74_0_1 -pt None -u 0.005884865838098663 > ./result_8chains/node74_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_2 -p 200 -st topic74_1_1 -pt None -u 0.007715401322118509 > ./result_8chains/node74_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_2 -p 451 -st topic74_2_1 -pt None -u 0.04655920827941812 > ./result_8chains/node74_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_2 -p 762 -st topic74_3_1 -pt None -u 0.023662234258443993 > ./result_8chains/node74_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_2 -p 811 -st topic74_4_1 -pt None -u 0.13025977698846145 > ./result_8chains/node74_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_2 -p 843 -st topic74_5_1 -pt None -u 0.0027474425922194845 > ./result_8chains/node74_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_2 -p 852 -st topic74_6_1 -pt None -u 0.014508474825672267 > ./result_8chains/node74_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_2 -p 995 -st topic74_7_1 -pt None -u 0.014544558373357337 > ./result_8chains/node74_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_0 -p 71 -st none -pt topic74_0_0 -u 0.009378130246408878 > ./result_8chains/node74_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_0 -p 200 -st none -pt topic74_1_0 -u 0.021165690129864856 > ./result_8chains/node74_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_0 -p 451 -st none -pt topic74_2_0 -u 0.005033636567410904 > ./result_8chains/node74_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_0 -p 762 -st none -pt topic74_3_0 -u 0.0016178113454611842 > ./result_8chains/node74_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_0 -p 811 -st none -pt topic74_4_0 -u 0.006875785038379101 > ./result_8chains/node74_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_0 -p 843 -st none -pt topic74_5_0 -u 0.02642672656090858 > ./result_8chains/node74_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_0 -p 852 -st none -pt topic74_6_0 -u 0.002249698994488819 > ./result_8chains/node74_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_0 -p 995 -st none -pt topic74_7_0 -u 0.0035546473578385654 > ./result_8chains/node74_7_0.txt &
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
    "./result_8chains/node74_0_0.txt 90"
    "./result_8chains/node74_0_2.txt 90"
    "./result_8chains/node74_1_0.txt 89"
    "./result_8chains/node74_1_2.txt 89"
    "./result_8chains/node74_2_0.txt 88"
    "./result_8chains/node74_2_2.txt 88"
    "./result_8chains/node74_3_0.txt 87"
    "./result_8chains/node74_3_2.txt 87"
    "./result_8chains/node74_4_0.txt 86"
    "./result_8chains/node74_4_2.txt 86"
    "./result_8chains/node74_5_0.txt 85"
    "./result_8chains/node74_5_2.txt 85"
    "./result_8chains/node74_6_0.txt 84"
    "./result_8chains/node74_6_2.txt 84"
    "./result_8chains/node74_7_0.txt 83"
    "./result_8chains/node74_7_2.txt 83"
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
