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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_2 -p 92 -st topic231_0_1 -pt None -u 0.014110130783004216 > ./result_10chains/node231_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_2 -p 184 -st topic231_1_1 -pt None -u 0.0012204223303841633 > ./result_10chains/node231_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_2 -p 219 -st topic231_2_1 -pt None -u 0.02215975587875768 > ./result_10chains/node231_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_2 -p 563 -st topic231_3_1 -pt None -u 0.02619546661337835 > ./result_10chains/node231_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_2 -p 674 -st topic231_4_1 -pt None -u 0.007897864610491356 > ./result_10chains/node231_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_2 -p 724 -st topic231_5_1 -pt None -u 0.013440305532681912 > ./result_10chains/node231_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_2 -p 754 -st topic231_6_1 -pt None -u 0.009215881705497392 > ./result_10chains/node231_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_2 -p 825 -st topic231_7_1 -pt None -u 0.0043073521801536285 > ./result_10chains/node231_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_8_2 -p 914 -st topic231_8_1 -pt None -u 0.015140208314845457 > ./result_10chains/node231_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_9_2 -p 992 -st topic231_9_1 -pt None -u 0.0001676422649706384 > ./result_10chains/node231_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_0 -p 92 -st none -pt topic231_0_0 -u 0.01400779292159543 > ./result_10chains/node231_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_0 -p 184 -st none -pt topic231_1_0 -u 0.0016540424768706763 > ./result_10chains/node231_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_0 -p 219 -st none -pt topic231_2_0 -u 0.030322385326445045 > ./result_10chains/node231_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_0 -p 563 -st none -pt topic231_3_0 -u 0.013531590955436434 > ./result_10chains/node231_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_0 -p 674 -st none -pt topic231_4_0 -u 0.010857897568249675 > ./result_10chains/node231_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_0 -p 724 -st none -pt topic231_5_0 -u 0.00735211073250408 > ./result_10chains/node231_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_0 -p 754 -st none -pt topic231_6_0 -u 0.017219185558890654 > ./result_10chains/node231_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_0 -p 825 -st none -pt topic231_7_0 -u 0.013206185290842637 > ./result_10chains/node231_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_8_0 -p 914 -st none -pt topic231_8_0 -u 0.00036658614959581004 > ./result_10chains/node231_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_9_0 -p 992 -st none -pt topic231_9_0 -u 0.019884083744334702 > ./result_10chains/node231_9_0.txt &
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
    "./result_10chains/node231_0_0.txt 90"
    "./result_10chains/node231_0_2.txt 90"
    "./result_10chains/node231_1_0.txt 89"
    "./result_10chains/node231_1_2.txt 89"
    "./result_10chains/node231_2_0.txt 88"
    "./result_10chains/node231_2_2.txt 88"
    "./result_10chains/node231_3_0.txt 87"
    "./result_10chains/node231_3_2.txt 87"
    "./result_10chains/node231_4_0.txt 86"
    "./result_10chains/node231_4_2.txt 86"
    "./result_10chains/node231_5_0.txt 85"
    "./result_10chains/node231_5_2.txt 85"
    "./result_10chains/node231_6_0.txt 84"
    "./result_10chains/node231_6_2.txt 84"
    "./result_10chains/node231_7_0.txt 83"
    "./result_10chains/node231_7_2.txt 83"
    "./result_10chains/node231_8_0.txt 82"
    "./result_10chains/node231_8_2.txt 82"
    "./result_10chains/node231_9_0.txt 81"
    "./result_10chains/node231_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
