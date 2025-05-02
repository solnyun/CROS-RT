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
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_2 -p 296 -st topic336_0_1 -pt None -u 0.019851707742543356 > ./result_8chains/node336_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_2 -p 345 -st topic336_1_1 -pt None -u 0.01257172341074042 > ./result_8chains/node336_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_2 -p 552 -st topic336_2_1 -pt None -u 0.034760222145839126 > ./result_8chains/node336_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_2 -p 708 -st topic336_3_1 -pt None -u 0.03348164763625128 > ./result_8chains/node336_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_2 -p 750 -st topic336_4_1 -pt None -u 0.04552226875629539 > ./result_8chains/node336_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_2 -p 838 -st topic336_5_1 -pt None -u 0.006108655990384487 > ./result_8chains/node336_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_6_2 -p 848 -st topic336_6_1 -pt None -u 0.03360816973969177 > ./result_8chains/node336_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_7_2 -p 934 -st topic336_7_1 -pt None -u 0.038455656913674655 > ./result_8chains/node336_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_0 -p 296 -st none -pt topic336_0_0 -u 0.010081778202585767 > ./result_8chains/node336_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_0 -p 345 -st none -pt topic336_1_0 -u 0.012155539372494029 > ./result_8chains/node336_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_0 -p 552 -st none -pt topic336_2_0 -u 0.04621274963775135 > ./result_8chains/node336_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_0 -p 708 -st none -pt topic336_3_0 -u 0.0017903559352757115 > ./result_8chains/node336_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_0 -p 750 -st none -pt topic336_4_0 -u 0.017358432020807668 > ./result_8chains/node336_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_0 -p 838 -st none -pt topic336_5_0 -u 0.00014154394075205357 > ./result_8chains/node336_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_6_0 -p 848 -st none -pt topic336_6_0 -u 0.03020788485872586 > ./result_8chains/node336_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node336_7_0 -p 934 -st none -pt topic336_7_0 -u 0.011119191931277222 > ./result_8chains/node336_7_0.txt &
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
    "./result_8chains/node336_0_0.txt 90"
    "./result_8chains/node336_0_2.txt 90"
    "./result_8chains/node336_1_0.txt 89"
    "./result_8chains/node336_1_2.txt 89"
    "./result_8chains/node336_2_0.txt 88"
    "./result_8chains/node336_2_2.txt 88"
    "./result_8chains/node336_3_0.txt 87"
    "./result_8chains/node336_3_2.txt 87"
    "./result_8chains/node336_4_0.txt 86"
    "./result_8chains/node336_4_2.txt 86"
    "./result_8chains/node336_5_0.txt 85"
    "./result_8chains/node336_5_2.txt 85"
    "./result_8chains/node336_6_0.txt 84"
    "./result_8chains/node336_6_2.txt 84"
    "./result_8chains/node336_7_0.txt 83"
    "./result_8chains/node336_7_2.txt 83"
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
