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
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_2 -p 284 -st topic165_0_1 -pt None -u 0.004952650127591163 > ./result_8chains/node165_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_2 -p 300 -st topic165_1_1 -pt None -u 0.01277373056042963 > ./result_8chains/node165_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_2 -p 335 -st topic165_2_1 -pt None -u 0.008251634122037443 > ./result_8chains/node165_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_2 -p 418 -st topic165_3_1 -pt None -u 0.041908004216270056 > ./result_8chains/node165_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_2 -p 499 -st topic165_4_1 -pt None -u 0.0015238132403690707 > ./result_8chains/node165_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_2 -p 938 -st topic165_5_1 -pt None -u 0.018372373183119947 > ./result_8chains/node165_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_6_2 -p 949 -st topic165_6_1 -pt None -u 0.02098237175356682 > ./result_8chains/node165_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_7_2 -p 968 -st topic165_7_1 -pt None -u 0.03143609566147053 > ./result_8chains/node165_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_0 -p 284 -st none -pt topic165_0_0 -u 0.006455284236550618 > ./result_8chains/node165_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_0 -p 300 -st none -pt topic165_1_0 -u 0.031091721280967766 > ./result_8chains/node165_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_0 -p 335 -st none -pt topic165_2_0 -u 0.015199690412203704 > ./result_8chains/node165_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_0 -p 418 -st none -pt topic165_3_0 -u 0.0067235460697882 > ./result_8chains/node165_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_0 -p 499 -st none -pt topic165_4_0 -u 0.023533000197488996 > ./result_8chains/node165_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_0 -p 938 -st none -pt topic165_5_0 -u 0.040779210125422766 > ./result_8chains/node165_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_6_0 -p 949 -st none -pt topic165_6_0 -u 0.017713873538578173 > ./result_8chains/node165_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_7_0 -p 968 -st none -pt topic165_7_0 -u 0.019496695482751042 > ./result_8chains/node165_7_0.txt &
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
    "./result_8chains/node165_0_0.txt 90"
    "./result_8chains/node165_0_2.txt 90"
    "./result_8chains/node165_1_0.txt 89"
    "./result_8chains/node165_1_2.txt 89"
    "./result_8chains/node165_2_0.txt 88"
    "./result_8chains/node165_2_2.txt 88"
    "./result_8chains/node165_3_0.txt 87"
    "./result_8chains/node165_3_2.txt 87"
    "./result_8chains/node165_4_0.txt 86"
    "./result_8chains/node165_4_2.txt 86"
    "./result_8chains/node165_5_0.txt 85"
    "./result_8chains/node165_5_2.txt 85"
    "./result_8chains/node165_6_0.txt 84"
    "./result_8chains/node165_6_2.txt 84"
    "./result_8chains/node165_7_0.txt 83"
    "./result_8chains/node165_7_2.txt 83"
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
