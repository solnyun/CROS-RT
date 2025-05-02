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
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_2 -p 85 -st topic392_0_1 -pt None -u 0.00048372927608819616 > ./result_10chains/node392_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_2 -p 104 -st topic392_1_1 -pt None -u 0.010635258559916538 > ./result_10chains/node392_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_2 -p 229 -st topic392_2_1 -pt None -u 0.0032599946820303094 > ./result_10chains/node392_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_2 -p 271 -st topic392_3_1 -pt None -u 0.025760816027747435 > ./result_10chains/node392_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_2 -p 535 -st topic392_4_1 -pt None -u 0.03776561626560185 > ./result_10chains/node392_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_2 -p 657 -st topic392_5_1 -pt None -u 0.004769059009246929 > ./result_10chains/node392_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_6_2 -p 688 -st topic392_6_1 -pt None -u 0.0024662357728457013 > ./result_10chains/node392_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_7_2 -p 704 -st topic392_7_1 -pt None -u 0.011309552662523162 > ./result_10chains/node392_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_8_2 -p 716 -st topic392_8_1 -pt None -u 0.02048047358005011 > ./result_10chains/node392_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_9_2 -p 933 -st topic392_9_1 -pt None -u 0.0003496966498357678 > ./result_10chains/node392_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_0 -p 85 -st none -pt topic392_0_0 -u 0.04082911080557494 > ./result_10chains/node392_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_0 -p 104 -st none -pt topic392_1_0 -u 0.06883901350831761 > ./result_10chains/node392_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_0 -p 229 -st none -pt topic392_2_0 -u 0.0125686771871788 > ./result_10chains/node392_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_0 -p 271 -st none -pt topic392_3_0 -u 0.002467135051811231 > ./result_10chains/node392_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_0 -p 535 -st none -pt topic392_4_0 -u 0.03580976463510621 > ./result_10chains/node392_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_0 -p 657 -st none -pt topic392_5_0 -u 0.040093820505072125 > ./result_10chains/node392_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_6_0 -p 688 -st none -pt topic392_6_0 -u 0.012384149667953898 > ./result_10chains/node392_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_7_0 -p 704 -st none -pt topic392_7_0 -u 0.007545338386588288 > ./result_10chains/node392_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_8_0 -p 716 -st none -pt topic392_8_0 -u 0.0011246956088134807 > ./result_10chains/node392_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_9_0 -p 933 -st none -pt topic392_9_0 -u 0.0258654713177921 > ./result_10chains/node392_9_0.txt &
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
    "./result_10chains/node392_0_0.txt 90"
    "./result_10chains/node392_0_2.txt 90"
    "./result_10chains/node392_1_0.txt 89"
    "./result_10chains/node392_1_2.txt 89"
    "./result_10chains/node392_2_0.txt 88"
    "./result_10chains/node392_2_2.txt 88"
    "./result_10chains/node392_3_0.txt 87"
    "./result_10chains/node392_3_2.txt 87"
    "./result_10chains/node392_4_0.txt 86"
    "./result_10chains/node392_4_2.txt 86"
    "./result_10chains/node392_5_0.txt 85"
    "./result_10chains/node392_5_2.txt 85"
    "./result_10chains/node392_6_0.txt 84"
    "./result_10chains/node392_6_2.txt 84"
    "./result_10chains/node392_7_0.txt 83"
    "./result_10chains/node392_7_2.txt 83"
    "./result_10chains/node392_8_0.txt 82"
    "./result_10chains/node392_8_2.txt 82"
    "./result_10chains/node392_9_0.txt 81"
    "./result_10chains/node392_9_2.txt 81"
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
