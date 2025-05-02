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
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_2 -p 73 -st topic463_0_1 -pt None -u 0.015612078928819884 > ./result_8chains/node463_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_2 -p 83 -st topic463_1_1 -pt None -u 0.00858523243454834 > ./result_8chains/node463_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_2 -p 280 -st topic463_2_1 -pt None -u 0.006444693635342891 > ./result_8chains/node463_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_2 -p 312 -st topic463_3_1 -pt None -u 0.02047534087962971 > ./result_8chains/node463_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_2 -p 431 -st topic463_4_1 -pt None -u 0.0011195487297490925 > ./result_8chains/node463_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_2 -p 818 -st topic463_5_1 -pt None -u 0.03673881852416182 > ./result_8chains/node463_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_6_2 -p 888 -st topic463_6_1 -pt None -u 0.0006561636374709801 > ./result_8chains/node463_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_7_2 -p 907 -st topic463_7_1 -pt None -u 0.0069370052923919375 > ./result_8chains/node463_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_0 -p 73 -st none -pt topic463_0_0 -u 0.01625787529217043 > ./result_8chains/node463_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_0 -p 83 -st none -pt topic463_1_0 -u 0.0015797911481689741 > ./result_8chains/node463_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_0 -p 280 -st none -pt topic463_2_0 -u 0.038852234026097665 > ./result_8chains/node463_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_0 -p 312 -st none -pt topic463_3_0 -u 0.01267236033386765 > ./result_8chains/node463_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_0 -p 431 -st none -pt topic463_4_0 -u 0.054114816636293306 > ./result_8chains/node463_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_0 -p 818 -st none -pt topic463_5_0 -u 0.006802431361508515 > ./result_8chains/node463_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_6_0 -p 888 -st none -pt topic463_6_0 -u 0.04410321293672434 > ./result_8chains/node463_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_7_0 -p 907 -st none -pt topic463_7_0 -u 0.028757464166747702 > ./result_8chains/node463_7_0.txt &
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
    "./result_8chains/node463_0_0.txt 90"
    "./result_8chains/node463_0_2.txt 90"
    "./result_8chains/node463_1_0.txt 89"
    "./result_8chains/node463_1_2.txt 89"
    "./result_8chains/node463_2_0.txt 88"
    "./result_8chains/node463_2_2.txt 88"
    "./result_8chains/node463_3_0.txt 87"
    "./result_8chains/node463_3_2.txt 87"
    "./result_8chains/node463_4_0.txt 86"
    "./result_8chains/node463_4_2.txt 86"
    "./result_8chains/node463_5_0.txt 85"
    "./result_8chains/node463_5_2.txt 85"
    "./result_8chains/node463_6_0.txt 84"
    "./result_8chains/node463_6_2.txt 84"
    "./result_8chains/node463_7_0.txt 83"
    "./result_8chains/node463_7_2.txt 83"
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
