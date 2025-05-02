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
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_2 -p 89 -st topic369_0_1 -pt None -u 0.07902223363406319 > ./result_8chains/node369_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_2 -p 221 -st topic369_1_1 -pt None -u 0.09787947042329215 > ./result_8chains/node369_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_2 -p 290 -st topic369_2_1 -pt None -u 0.02343656693072571 > ./result_8chains/node369_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_2 -p 433 -st topic369_3_1 -pt None -u 0.009016368247121376 > ./result_8chains/node369_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_2 -p 674 -st topic369_4_1 -pt None -u 0.009279555988692678 > ./result_8chains/node369_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_2 -p 677 -st topic369_5_1 -pt None -u 0.014435996916080732 > ./result_8chains/node369_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_6_2 -p 721 -st topic369_6_1 -pt None -u 0.0072064231387567665 > ./result_8chains/node369_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_7_2 -p 832 -st topic369_7_1 -pt None -u 0.02530293668098151 > ./result_8chains/node369_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_0 -p 89 -st none -pt topic369_0_0 -u 0.004087559157155252 > ./result_8chains/node369_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_0 -p 221 -st none -pt topic369_1_0 -u 0.0031309744777415216 > ./result_8chains/node369_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_0 -p 290 -st none -pt topic369_2_0 -u 0.05341342292048279 > ./result_8chains/node369_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_0 -p 433 -st none -pt topic369_3_0 -u 0.0031334344730669095 > ./result_8chains/node369_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_0 -p 674 -st none -pt topic369_4_0 -u 0.0006204589721165721 > ./result_8chains/node369_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_0 -p 677 -st none -pt topic369_5_0 -u 0.010132399622251667 > ./result_8chains/node369_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_6_0 -p 721 -st none -pt topic369_6_0 -u 0.03584922837229053 > ./result_8chains/node369_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_7_0 -p 832 -st none -pt topic369_7_0 -u 0.020476878920652003 > ./result_8chains/node369_7_0.txt &
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
    "./result_8chains/node369_0_0.txt 90"
    "./result_8chains/node369_0_2.txt 90"
    "./result_8chains/node369_1_0.txt 89"
    "./result_8chains/node369_1_2.txt 89"
    "./result_8chains/node369_2_0.txt 88"
    "./result_8chains/node369_2_2.txt 88"
    "./result_8chains/node369_3_0.txt 87"
    "./result_8chains/node369_3_2.txt 87"
    "./result_8chains/node369_4_0.txt 86"
    "./result_8chains/node369_4_2.txt 86"
    "./result_8chains/node369_5_0.txt 85"
    "./result_8chains/node369_5_2.txt 85"
    "./result_8chains/node369_6_0.txt 84"
    "./result_8chains/node369_6_2.txt 84"
    "./result_8chains/node369_7_0.txt 83"
    "./result_8chains/node369_7_2.txt 83"
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
