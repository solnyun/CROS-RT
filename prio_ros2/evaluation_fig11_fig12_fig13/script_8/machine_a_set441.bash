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
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_2 -p 15 -st topic441_0_1 -pt None -u 0.012767677055558035 > ./result_8chains/node441_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_2 -p 188 -st topic441_1_1 -pt None -u 0.017144557215440337 > ./result_8chains/node441_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_2 -p 216 -st topic441_2_1 -pt None -u 0.042094400993603176 > ./result_8chains/node441_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_2 -p 288 -st topic441_3_1 -pt None -u 0.00272719594591192 > ./result_8chains/node441_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_2 -p 493 -st topic441_4_1 -pt None -u 0.05129497740526648 > ./result_8chains/node441_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_2 -p 704 -st topic441_5_1 -pt None -u 0.014849988581171175 > ./result_8chains/node441_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_2 -p 837 -st topic441_6_1 -pt None -u 0.05022540368146151 > ./result_8chains/node441_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_2 -p 942 -st topic441_7_1 -pt None -u 0.002671126287863921 > ./result_8chains/node441_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_0 -p 15 -st none -pt topic441_0_0 -u 0.03131860621784199 > ./result_8chains/node441_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_0 -p 188 -st none -pt topic441_1_0 -u 0.01812535763237566 > ./result_8chains/node441_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_0 -p 216 -st none -pt topic441_2_0 -u 0.03140681024117592 > ./result_8chains/node441_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_0 -p 288 -st none -pt topic441_3_0 -u 0.0037157440747832005 > ./result_8chains/node441_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_0 -p 493 -st none -pt topic441_4_0 -u 0.024862717564341386 > ./result_8chains/node441_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_0 -p 704 -st none -pt topic441_5_0 -u 0.0020901149193355284 > ./result_8chains/node441_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_0 -p 837 -st none -pt topic441_6_0 -u 0.0319090783848279 > ./result_8chains/node441_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_0 -p 942 -st none -pt topic441_7_0 -u 0.01874404655495117 > ./result_8chains/node441_7_0.txt &
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
    "./result_8chains/node441_0_0.txt 90"
    "./result_8chains/node441_0_2.txt 90"
    "./result_8chains/node441_1_0.txt 89"
    "./result_8chains/node441_1_2.txt 89"
    "./result_8chains/node441_2_0.txt 88"
    "./result_8chains/node441_2_2.txt 88"
    "./result_8chains/node441_3_0.txt 87"
    "./result_8chains/node441_3_2.txt 87"
    "./result_8chains/node441_4_0.txt 86"
    "./result_8chains/node441_4_2.txt 86"
    "./result_8chains/node441_5_0.txt 85"
    "./result_8chains/node441_5_2.txt 85"
    "./result_8chains/node441_6_0.txt 84"
    "./result_8chains/node441_6_2.txt 84"
    "./result_8chains/node441_7_0.txt 83"
    "./result_8chains/node441_7_2.txt 83"
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
