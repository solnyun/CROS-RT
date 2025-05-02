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
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_2 -p 14 -st topic477_0_1 -pt None -u 0.046159791288060914 > ./result_6chains/node477_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_2 -p 25 -st topic477_1_1 -pt None -u 0.0006722227636128952 > ./result_6chains/node477_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_2 -p 93 -st topic477_2_1 -pt None -u 0.025948774002891917 > ./result_6chains/node477_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_2 -p 335 -st topic477_3_1 -pt None -u 0.0026316123100966204 > ./result_6chains/node477_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_2 -p 541 -st topic477_4_1 -pt None -u 0.02996789725252815 > ./result_6chains/node477_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_2 -p 638 -st topic477_5_1 -pt None -u 0.012570121349902631 > ./result_6chains/node477_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_0 -p 14 -st none -pt topic477_0_0 -u 0.017586076650253912 > ./result_6chains/node477_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_0 -p 25 -st none -pt topic477_1_0 -u 0.05265040684019556 > ./result_6chains/node477_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_0 -p 93 -st none -pt topic477_2_0 -u 0.038325537606586246 > ./result_6chains/node477_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_0 -p 335 -st none -pt topic477_3_0 -u 0.01587487199388088 > ./result_6chains/node477_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_0 -p 541 -st none -pt topic477_4_0 -u 0.046492627646367635 > ./result_6chains/node477_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_0 -p 638 -st none -pt topic477_5_0 -u 0.0030700361440253628 > ./result_6chains/node477_5_0.txt &
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
    "./result_6chains/node477_0_0.txt 90"
    "./result_6chains/node477_0_2.txt 90"
    "./result_6chains/node477_1_0.txt 89"
    "./result_6chains/node477_1_2.txt 89"
    "./result_6chains/node477_2_0.txt 88"
    "./result_6chains/node477_2_2.txt 88"
    "./result_6chains/node477_3_0.txt 87"
    "./result_6chains/node477_3_2.txt 87"
    "./result_6chains/node477_4_0.txt 86"
    "./result_6chains/node477_4_2.txt 86"
    "./result_6chains/node477_5_0.txt 85"
    "./result_6chains/node477_5_2.txt 85"
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
