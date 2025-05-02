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
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_2 -p 95 -st topic367_0_1 -pt None -u 0.029956666875237903 > ./result_10chains/node367_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_2 -p 102 -st topic367_1_1 -pt None -u 0.00026184237838466906 > ./result_10chains/node367_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_2 -p 170 -st topic367_2_1 -pt None -u 0.03847114511533817 > ./result_10chains/node367_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_2 -p 308 -st topic367_3_1 -pt None -u 0.0008747397130342005 > ./result_10chains/node367_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_2 -p 357 -st topic367_4_1 -pt None -u 0.018817443744362367 > ./result_10chains/node367_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_2 -p 420 -st topic367_5_1 -pt None -u 0.009091955426554582 > ./result_10chains/node367_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_6_2 -p 453 -st topic367_6_1 -pt None -u 0.013947675928896591 > ./result_10chains/node367_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_7_2 -p 600 -st topic367_7_1 -pt None -u 0.0022577703419478234 > ./result_10chains/node367_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_8_2 -p 640 -st topic367_8_1 -pt None -u 0.01983314489577906 > ./result_10chains/node367_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_9_2 -p 935 -st topic367_9_1 -pt None -u 1.1814361807347033e-05 > ./result_10chains/node367_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_0 -p 95 -st none -pt topic367_0_0 -u 0.050550671057710994 > ./result_10chains/node367_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_0 -p 102 -st none -pt topic367_1_0 -u 0.009838348033113398 > ./result_10chains/node367_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_0 -p 170 -st none -pt topic367_2_0 -u 0.010535735847572003 > ./result_10chains/node367_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_0 -p 308 -st none -pt topic367_3_0 -u 0.012005173478780662 > ./result_10chains/node367_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_0 -p 357 -st none -pt topic367_4_0 -u 0.009402995920865742 > ./result_10chains/node367_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_0 -p 420 -st none -pt topic367_5_0 -u 0.007644449062382097 > ./result_10chains/node367_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_6_0 -p 453 -st none -pt topic367_6_0 -u 0.005086726657714036 > ./result_10chains/node367_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_7_0 -p 600 -st none -pt topic367_7_0 -u 0.00820639588861613 > ./result_10chains/node367_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_8_0 -p 640 -st none -pt topic367_8_0 -u 0.001443163104970585 > ./result_10chains/node367_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_9_0 -p 935 -st none -pt topic367_9_0 -u 0.016880480093406945 > ./result_10chains/node367_9_0.txt &
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
    "./result_10chains/node367_0_0.txt 90"
    "./result_10chains/node367_0_2.txt 90"
    "./result_10chains/node367_1_0.txt 89"
    "./result_10chains/node367_1_2.txt 89"
    "./result_10chains/node367_2_0.txt 88"
    "./result_10chains/node367_2_2.txt 88"
    "./result_10chains/node367_3_0.txt 87"
    "./result_10chains/node367_3_2.txt 87"
    "./result_10chains/node367_4_0.txt 86"
    "./result_10chains/node367_4_2.txt 86"
    "./result_10chains/node367_5_0.txt 85"
    "./result_10chains/node367_5_2.txt 85"
    "./result_10chains/node367_6_0.txt 84"
    "./result_10chains/node367_6_2.txt 84"
    "./result_10chains/node367_7_0.txt 83"
    "./result_10chains/node367_7_2.txt 83"
    "./result_10chains/node367_8_0.txt 82"
    "./result_10chains/node367_8_2.txt 82"
    "./result_10chains/node367_9_0.txt 81"
    "./result_10chains/node367_9_2.txt 81"
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
