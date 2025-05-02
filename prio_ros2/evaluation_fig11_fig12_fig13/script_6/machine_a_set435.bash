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
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_2 -p 83 -st topic435_0_1 -pt None -u 0.0499785588269927 > ./result_6chains/node435_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_2 -p 349 -st topic435_1_1 -pt None -u 0.01645888230273901 > ./result_6chains/node435_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_2 -p 437 -st topic435_2_1 -pt None -u 0.00047964711056910914 > ./result_6chains/node435_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_2 -p 456 -st topic435_3_1 -pt None -u 0.019482608355124817 > ./result_6chains/node435_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_2 -p 513 -st topic435_4_1 -pt None -u 0.06058178439787543 > ./result_6chains/node435_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_2 -p 735 -st topic435_5_1 -pt None -u 0.013076661277467353 > ./result_6chains/node435_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_0 -p 83 -st none -pt topic435_0_0 -u 0.019173464863462053 > ./result_6chains/node435_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_0 -p 349 -st none -pt topic435_1_0 -u 0.03748475641170529 > ./result_6chains/node435_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_0 -p 437 -st none -pt topic435_2_0 -u 0.05796486319814226 > ./result_6chains/node435_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_0 -p 456 -st none -pt topic435_3_0 -u 0.005500460798729179 > ./result_6chains/node435_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_0 -p 513 -st none -pt topic435_4_0 -u 0.013412963135544645 > ./result_6chains/node435_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_0 -p 735 -st none -pt topic435_5_0 -u 0.004528901307285241 > ./result_6chains/node435_5_0.txt &
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
    "./result_6chains/node435_0_0.txt 90"
    "./result_6chains/node435_0_2.txt 90"
    "./result_6chains/node435_1_0.txt 89"
    "./result_6chains/node435_1_2.txt 89"
    "./result_6chains/node435_2_0.txt 88"
    "./result_6chains/node435_2_2.txt 88"
    "./result_6chains/node435_3_0.txt 87"
    "./result_6chains/node435_3_2.txt 87"
    "./result_6chains/node435_4_0.txt 86"
    "./result_6chains/node435_4_2.txt 86"
    "./result_6chains/node435_5_0.txt 85"
    "./result_6chains/node435_5_2.txt 85"
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
