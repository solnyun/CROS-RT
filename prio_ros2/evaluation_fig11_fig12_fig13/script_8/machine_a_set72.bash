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
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_2 -p 133 -st topic72_0_1 -pt None -u 0.047803642939516 > ./result_8chains/node72_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_2 -p 157 -st topic72_1_1 -pt None -u 0.010320199324586221 > ./result_8chains/node72_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_2 -p 232 -st topic72_2_1 -pt None -u 0.012788656115339692 > ./result_8chains/node72_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_2 -p 591 -st topic72_3_1 -pt None -u 0.003822329752545095 > ./result_8chains/node72_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_2 -p 645 -st topic72_4_1 -pt None -u 0.007171009990330102 > ./result_8chains/node72_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_2 -p 787 -st topic72_5_1 -pt None -u 0.02690207822336707 > ./result_8chains/node72_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_2 -p 911 -st topic72_6_1 -pt None -u 0.031422157548605265 > ./result_8chains/node72_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_2 -p 987 -st topic72_7_1 -pt None -u 0.012406025920939074 > ./result_8chains/node72_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_0 -p 133 -st none -pt topic72_0_0 -u 0.016682043885166475 > ./result_8chains/node72_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_0 -p 157 -st none -pt topic72_1_0 -u 0.01371721725527486 > ./result_8chains/node72_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_0 -p 232 -st none -pt topic72_2_0 -u 0.038932874859410826 > ./result_8chains/node72_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_0 -p 591 -st none -pt topic72_3_0 -u 0.025828438494054973 > ./result_8chains/node72_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_0 -p 645 -st none -pt topic72_4_0 -u 0.012346799742722597 > ./result_8chains/node72_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_0 -p 787 -st none -pt topic72_5_0 -u 0.0015978490784891997 > ./result_8chains/node72_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_0 -p 911 -st none -pt topic72_6_0 -u 0.018692312322625262 > ./result_8chains/node72_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_0 -p 987 -st none -pt topic72_7_0 -u 0.02921631335358224 > ./result_8chains/node72_7_0.txt &
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
    "./result_8chains/node72_0_0.txt 90"
    "./result_8chains/node72_0_2.txt 90"
    "./result_8chains/node72_1_0.txt 89"
    "./result_8chains/node72_1_2.txt 89"
    "./result_8chains/node72_2_0.txt 88"
    "./result_8chains/node72_2_2.txt 88"
    "./result_8chains/node72_3_0.txt 87"
    "./result_8chains/node72_3_2.txt 87"
    "./result_8chains/node72_4_0.txt 86"
    "./result_8chains/node72_4_2.txt 86"
    "./result_8chains/node72_5_0.txt 85"
    "./result_8chains/node72_5_2.txt 85"
    "./result_8chains/node72_6_0.txt 84"
    "./result_8chains/node72_6_2.txt 84"
    "./result_8chains/node72_7_0.txt 83"
    "./result_8chains/node72_7_2.txt 83"
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
