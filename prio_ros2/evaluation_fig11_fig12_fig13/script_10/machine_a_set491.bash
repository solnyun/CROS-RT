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
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_2 -p 66 -st topic491_0_1 -pt None -u 0.014654686002894657 > ./result_10chains/node491_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_2 -p 154 -st topic491_1_1 -pt None -u 0.00840298219025759 > ./result_10chains/node491_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_2 -p 426 -st topic491_2_1 -pt None -u 0.039473479416670565 > ./result_10chains/node491_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_2 -p 470 -st topic491_3_1 -pt None -u 0.014294024425395513 > ./result_10chains/node491_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_2 -p 612 -st topic491_4_1 -pt None -u 0.007246272967918493 > ./result_10chains/node491_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_2 -p 643 -st topic491_5_1 -pt None -u 0.026907249673695385 > ./result_10chains/node491_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_6_2 -p 886 -st topic491_6_1 -pt None -u 0.010163231704597417 > ./result_10chains/node491_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_7_2 -p 893 -st topic491_7_1 -pt None -u 0.012140282497273544 > ./result_10chains/node491_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_8_2 -p 945 -st topic491_8_1 -pt None -u 0.0030344526243236553 > ./result_10chains/node491_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_9_2 -p 973 -st topic491_9_1 -pt None -u 0.039400702454790895 > ./result_10chains/node491_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_0 -p 66 -st none -pt topic491_0_0 -u 0.009352482903849824 > ./result_10chains/node491_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_0 -p 154 -st none -pt topic491_1_0 -u 0.013532781042403796 > ./result_10chains/node491_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_0 -p 426 -st none -pt topic491_2_0 -u 0.019974524407398886 > ./result_10chains/node491_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_0 -p 470 -st none -pt topic491_3_0 -u 0.0006074760493727238 > ./result_10chains/node491_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_0 -p 612 -st none -pt topic491_4_0 -u 0.05402325115289333 > ./result_10chains/node491_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_0 -p 643 -st none -pt topic491_5_0 -u 0.03801024360375599 > ./result_10chains/node491_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_6_0 -p 886 -st none -pt topic491_6_0 -u 0.00527385196407118 > ./result_10chains/node491_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_7_0 -p 893 -st none -pt topic491_7_0 -u 0.006424458193574345 > ./result_10chains/node491_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_8_0 -p 945 -st none -pt topic491_8_0 -u 0.0030922977196209955 > ./result_10chains/node491_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_9_0 -p 973 -st none -pt topic491_9_0 -u 0.009825885369887231 > ./result_10chains/node491_9_0.txt &
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
    "./result_10chains/node491_0_0.txt 90"
    "./result_10chains/node491_0_2.txt 90"
    "./result_10chains/node491_1_0.txt 89"
    "./result_10chains/node491_1_2.txt 89"
    "./result_10chains/node491_2_0.txt 88"
    "./result_10chains/node491_2_2.txt 88"
    "./result_10chains/node491_3_0.txt 87"
    "./result_10chains/node491_3_2.txt 87"
    "./result_10chains/node491_4_0.txt 86"
    "./result_10chains/node491_4_2.txt 86"
    "./result_10chains/node491_5_0.txt 85"
    "./result_10chains/node491_5_2.txt 85"
    "./result_10chains/node491_6_0.txt 84"
    "./result_10chains/node491_6_2.txt 84"
    "./result_10chains/node491_7_0.txt 83"
    "./result_10chains/node491_7_2.txt 83"
    "./result_10chains/node491_8_0.txt 82"
    "./result_10chains/node491_8_2.txt 82"
    "./result_10chains/node491_9_0.txt 81"
    "./result_10chains/node491_9_2.txt 81"
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
