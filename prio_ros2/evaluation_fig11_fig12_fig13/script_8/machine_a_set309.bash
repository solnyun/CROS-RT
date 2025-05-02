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
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_2 -p 55 -st topic309_0_1 -pt None -u 0.012138935818989172 > ./result_8chains/node309_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_2 -p 62 -st topic309_1_1 -pt None -u 0.012948134270140965 > ./result_8chains/node309_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_2 -p 289 -st topic309_2_1 -pt None -u 0.03992806867204984 > ./result_8chains/node309_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_2 -p 309 -st topic309_3_1 -pt None -u 0.003732718884243369 > ./result_8chains/node309_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_2 -p 454 -st topic309_4_1 -pt None -u 0.003991946542776265 > ./result_8chains/node309_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_2 -p 456 -st topic309_5_1 -pt None -u 0.04113643703194564 > ./result_8chains/node309_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_6_2 -p 500 -st topic309_6_1 -pt None -u 0.04696073965175987 > ./result_8chains/node309_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_7_2 -p 929 -st topic309_7_1 -pt None -u 0.007702535515892011 > ./result_8chains/node309_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_0 -p 55 -st none -pt topic309_0_0 -u 0.003457481521644379 > ./result_8chains/node309_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_0 -p 62 -st none -pt topic309_1_0 -u 0.022261290854776183 > ./result_8chains/node309_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_0 -p 289 -st none -pt topic309_2_0 -u 0.02628234870068885 > ./result_8chains/node309_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_0 -p 309 -st none -pt topic309_3_0 -u 0.0031126424591100266 > ./result_8chains/node309_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_0 -p 454 -st none -pt topic309_4_0 -u 0.0016658212104507242 > ./result_8chains/node309_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_0 -p 456 -st none -pt topic309_5_0 -u 0.03974372799593179 > ./result_8chains/node309_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_6_0 -p 500 -st none -pt topic309_6_0 -u 0.007028190756120656 > ./result_8chains/node309_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_7_0 -p 929 -st none -pt topic309_7_0 -u 0.002044676933765921 > ./result_8chains/node309_7_0.txt &
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
    "./result_8chains/node309_0_0.txt 90"
    "./result_8chains/node309_0_2.txt 90"
    "./result_8chains/node309_1_0.txt 89"
    "./result_8chains/node309_1_2.txt 89"
    "./result_8chains/node309_2_0.txt 88"
    "./result_8chains/node309_2_2.txt 88"
    "./result_8chains/node309_3_0.txt 87"
    "./result_8chains/node309_3_2.txt 87"
    "./result_8chains/node309_4_0.txt 86"
    "./result_8chains/node309_4_2.txt 86"
    "./result_8chains/node309_5_0.txt 85"
    "./result_8chains/node309_5_2.txt 85"
    "./result_8chains/node309_6_0.txt 84"
    "./result_8chains/node309_6_2.txt 84"
    "./result_8chains/node309_7_0.txt 83"
    "./result_8chains/node309_7_2.txt 83"
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
