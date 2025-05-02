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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_2 -p 54 -st topic370_0_1 -pt None -u 0.028124858313902656 > ./result_8chains/node370_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_2 -p 163 -st topic370_1_1 -pt None -u 0.014520302617350822 > ./result_8chains/node370_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_2 -p 234 -st topic370_2_1 -pt None -u 0.00038206964492037976 > ./result_8chains/node370_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_2 -p 493 -st topic370_3_1 -pt None -u 0.011842498869495705 > ./result_8chains/node370_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_2 -p 641 -st topic370_4_1 -pt None -u 0.020086424367281086 > ./result_8chains/node370_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_2 -p 726 -st topic370_5_1 -pt None -u 0.019681354357003536 > ./result_8chains/node370_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_2 -p 839 -st topic370_6_1 -pt None -u 0.008348265266634486 > ./result_8chains/node370_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_2 -p 997 -st topic370_7_1 -pt None -u 0.0037557694072244924 > ./result_8chains/node370_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_0 -p 54 -st none -pt topic370_0_0 -u 0.014976271997140023 > ./result_8chains/node370_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_0 -p 163 -st none -pt topic370_1_0 -u 0.1463070337597614 > ./result_8chains/node370_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_0 -p 234 -st none -pt topic370_2_0 -u 0.00948205261072066 > ./result_8chains/node370_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_0 -p 493 -st none -pt topic370_3_0 -u 0.024154392651863643 > ./result_8chains/node370_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_0 -p 641 -st none -pt topic370_4_0 -u 0.014135187154870277 > ./result_8chains/node370_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_0 -p 726 -st none -pt topic370_5_0 -u 0.017128417891366376 > ./result_8chains/node370_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_0 -p 839 -st none -pt topic370_6_0 -u 0.021885111397265594 > ./result_8chains/node370_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_0 -p 997 -st none -pt topic370_7_0 -u 0.013603982792255623 > ./result_8chains/node370_7_0.txt &
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
    "./result_8chains/node370_0_0.txt 90"
    "./result_8chains/node370_0_2.txt 90"
    "./result_8chains/node370_1_0.txt 89"
    "./result_8chains/node370_1_2.txt 89"
    "./result_8chains/node370_2_0.txt 88"
    "./result_8chains/node370_2_2.txt 88"
    "./result_8chains/node370_3_0.txt 87"
    "./result_8chains/node370_3_2.txt 87"
    "./result_8chains/node370_4_0.txt 86"
    "./result_8chains/node370_4_2.txt 86"
    "./result_8chains/node370_5_0.txt 85"
    "./result_8chains/node370_5_2.txt 85"
    "./result_8chains/node370_6_0.txt 84"
    "./result_8chains/node370_6_2.txt 84"
    "./result_8chains/node370_7_0.txt 83"
    "./result_8chains/node370_7_2.txt 83"
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
