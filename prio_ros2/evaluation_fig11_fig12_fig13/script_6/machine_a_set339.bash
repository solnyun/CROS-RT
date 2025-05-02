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
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_2 -p 50 -st topic339_0_1 -pt None -u 0.007692263585254211 > ./result_6chains/node339_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_2 -p 224 -st topic339_1_1 -pt None -u 0.020350709149512924 > ./result_6chains/node339_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_2 -p 534 -st topic339_2_1 -pt None -u 0.05811413193708881 > ./result_6chains/node339_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_2 -p 573 -st topic339_3_1 -pt None -u 0.009785653098790925 > ./result_6chains/node339_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_2 -p 839 -st topic339_4_1 -pt None -u 0.037382184217543246 > ./result_6chains/node339_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_2 -p 883 -st topic339_5_1 -pt None -u 0.022230250736305815 > ./result_6chains/node339_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_0 -p 50 -st none -pt topic339_0_0 -u 0.009492934409658482 > ./result_6chains/node339_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_0 -p 224 -st none -pt topic339_1_0 -u 0.0018852820400181436 > ./result_6chains/node339_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_0 -p 534 -st none -pt topic339_2_0 -u 0.050224859833257585 > ./result_6chains/node339_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_0 -p 573 -st none -pt topic339_3_0 -u 0.002222385199271204 > ./result_6chains/node339_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_0 -p 839 -st none -pt topic339_4_0 -u 0.019106870226565542 > ./result_6chains/node339_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_0 -p 883 -st none -pt topic339_5_0 -u 0.01784284925964412 > ./result_6chains/node339_5_0.txt &
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
    "./result_6chains/node339_0_0.txt 90"
    "./result_6chains/node339_0_2.txt 90"
    "./result_6chains/node339_1_0.txt 89"
    "./result_6chains/node339_1_2.txt 89"
    "./result_6chains/node339_2_0.txt 88"
    "./result_6chains/node339_2_2.txt 88"
    "./result_6chains/node339_3_0.txt 87"
    "./result_6chains/node339_3_2.txt 87"
    "./result_6chains/node339_4_0.txt 86"
    "./result_6chains/node339_4_2.txt 86"
    "./result_6chains/node339_5_0.txt 85"
    "./result_6chains/node339_5_2.txt 85"
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
