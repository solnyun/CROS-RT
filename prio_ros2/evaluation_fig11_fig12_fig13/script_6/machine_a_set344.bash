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
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_2 -p 320 -st topic344_0_1 -pt None -u 0.040170519682768135 > ./result_6chains/node344_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_2 -p 332 -st topic344_1_1 -pt None -u 0.005721341206723574 > ./result_6chains/node344_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_2 -p 525 -st topic344_2_1 -pt None -u 0.0019033160251362147 > ./result_6chains/node344_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_2 -p 633 -st topic344_3_1 -pt None -u 0.024403273354336397 > ./result_6chains/node344_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_2 -p 741 -st topic344_4_1 -pt None -u 0.03688285445617093 > ./result_6chains/node344_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_2 -p 922 -st topic344_5_1 -pt None -u 0.0037627871558636532 > ./result_6chains/node344_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_0 -p 320 -st none -pt topic344_0_0 -u 0.0287986558513304 > ./result_6chains/node344_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_0 -p 332 -st none -pt topic344_1_0 -u 0.004597432057519002 > ./result_6chains/node344_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_0 -p 525 -st none -pt topic344_2_0 -u 0.0286345690339328 > ./result_6chains/node344_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_0 -p 633 -st none -pt topic344_3_0 -u 0.034734175634123565 > ./result_6chains/node344_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_0 -p 741 -st none -pt topic344_4_0 -u 0.007077234114664821 > ./result_6chains/node344_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_0 -p 922 -st none -pt topic344_5_0 -u 0.06563079880437987 > ./result_6chains/node344_5_0.txt &
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
    "./result_6chains/node344_0_0.txt 90"
    "./result_6chains/node344_0_2.txt 90"
    "./result_6chains/node344_1_0.txt 89"
    "./result_6chains/node344_1_2.txt 89"
    "./result_6chains/node344_2_0.txt 88"
    "./result_6chains/node344_2_2.txt 88"
    "./result_6chains/node344_3_0.txt 87"
    "./result_6chains/node344_3_2.txt 87"
    "./result_6chains/node344_4_0.txt 86"
    "./result_6chains/node344_4_2.txt 86"
    "./result_6chains/node344_5_0.txt 85"
    "./result_6chains/node344_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
