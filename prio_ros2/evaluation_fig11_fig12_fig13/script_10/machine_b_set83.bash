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
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_1 -p 63 -st topic83_0_0 -pt topic83_0_1 -u 0.017821380858023206 > ./result_10chains/node83_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_1 -p 70 -st topic83_1_0 -pt topic83_1_1 -u 0.009944924180842307 > ./result_10chains/node83_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_1 -p 136 -st topic83_2_0 -pt topic83_2_1 -u 0.016569372643315927 > ./result_10chains/node83_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_1 -p 288 -st topic83_3_0 -pt topic83_3_1 -u 0.009974916047695459 > ./result_10chains/node83_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_1 -p 321 -st topic83_4_0 -pt topic83_4_1 -u 0.041848963480954515 > ./result_10chains/node83_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_1 -p 373 -st topic83_5_0 -pt topic83_5_1 -u 0.010072742005927948 > ./result_10chains/node83_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_1 -p 485 -st topic83_6_0 -pt topic83_6_1 -u 0.019255180215799778 > ./result_10chains/node83_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_1 -p 764 -st topic83_7_0 -pt topic83_7_1 -u 0.006207559635665216 > ./result_10chains/node83_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_8_1 -p 952 -st topic83_8_0 -pt topic83_8_1 -u 0.0054516283923260744 > ./result_10chains/node83_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_9_1 -p 988 -st topic83_9_0 -pt topic83_9_1 -u 0.04319305265410802 > ./result_10chains/node83_9_1.txt &
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
    "./result_10chains/node83_0_1.txt 90"
    "./result_10chains/node83_1_1.txt 89"
    "./result_10chains/node83_2_1.txt 88"
    "./result_10chains/node83_3_1.txt 87"
    "./result_10chains/node83_4_1.txt 86"
    "./result_10chains/node83_5_1.txt 85"
    "./result_10chains/node83_6_1.txt 84"
    "./result_10chains/node83_7_1.txt 83"
    "./result_10chains/node83_8_1.txt 82"
    "./result_10chains/node83_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
