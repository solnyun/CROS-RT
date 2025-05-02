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
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_2 -p 331 -st topic248_0_1 -pt None -u 0.009457542239214967 > ./result_8chains/node248_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_2 -p 525 -st topic248_1_1 -pt None -u 0.03953304932409463 > ./result_8chains/node248_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_2 -p 579 -st topic248_2_1 -pt None -u 0.024452970615865266 > ./result_8chains/node248_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_2 -p 628 -st topic248_3_1 -pt None -u 0.0006518481848384883 > ./result_8chains/node248_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_2 -p 906 -st topic248_4_1 -pt None -u 0.01426154240919536 > ./result_8chains/node248_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_2 -p 938 -st topic248_5_1 -pt None -u 0.005692002272046526 > ./result_8chains/node248_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_2 -p 953 -st topic248_6_1 -pt None -u 0.020380678222339202 > ./result_8chains/node248_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_2 -p 961 -st topic248_7_1 -pt None -u 0.07893506435949525 > ./result_8chains/node248_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_0 -p 331 -st none -pt topic248_0_0 -u 0.02572992479326386 > ./result_8chains/node248_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_0 -p 525 -st none -pt topic248_1_0 -u 0.033609652308089266 > ./result_8chains/node248_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_0 -p 579 -st none -pt topic248_2_0 -u 0.008293586926734209 > ./result_8chains/node248_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_0 -p 628 -st none -pt topic248_3_0 -u 0.008925445662470555 > ./result_8chains/node248_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_0 -p 906 -st none -pt topic248_4_0 -u 0.021107044582459322 > ./result_8chains/node248_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_0 -p 938 -st none -pt topic248_5_0 -u 0.01036182072917069 > ./result_8chains/node248_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_0 -p 953 -st none -pt topic248_6_0 -u 0.03812927713254777 > ./result_8chains/node248_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_0 -p 961 -st none -pt topic248_7_0 -u 0.0044198755078819485 > ./result_8chains/node248_7_0.txt &
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
    "./result_8chains/node248_0_0.txt 90"
    "./result_8chains/node248_0_2.txt 90"
    "./result_8chains/node248_1_0.txt 89"
    "./result_8chains/node248_1_2.txt 89"
    "./result_8chains/node248_2_0.txt 88"
    "./result_8chains/node248_2_2.txt 88"
    "./result_8chains/node248_3_0.txt 87"
    "./result_8chains/node248_3_2.txt 87"
    "./result_8chains/node248_4_0.txt 86"
    "./result_8chains/node248_4_2.txt 86"
    "./result_8chains/node248_5_0.txt 85"
    "./result_8chains/node248_5_2.txt 85"
    "./result_8chains/node248_6_0.txt 84"
    "./result_8chains/node248_6_2.txt 84"
    "./result_8chains/node248_7_0.txt 83"
    "./result_8chains/node248_7_2.txt 83"
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
