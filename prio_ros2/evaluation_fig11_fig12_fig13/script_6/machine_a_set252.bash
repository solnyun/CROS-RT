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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_2 -p 49 -st topic252_0_1 -pt None -u 0.00020881182047000069 > ./result_6chains/node252_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_2 -p 56 -st topic252_1_1 -pt None -u 0.042974370798417205 > ./result_6chains/node252_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_2 -p 278 -st topic252_2_1 -pt None -u 0.00794069993115687 > ./result_6chains/node252_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_2 -p 418 -st topic252_3_1 -pt None -u 0.05267655478146768 > ./result_6chains/node252_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_2 -p 456 -st topic252_4_1 -pt None -u 0.002140939158405339 > ./result_6chains/node252_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_2 -p 755 -st topic252_5_1 -pt None -u 0.02530367992235026 > ./result_6chains/node252_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_0 -p 49 -st none -pt topic252_0_0 -u 0.009333911810279094 > ./result_6chains/node252_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_0 -p 56 -st none -pt topic252_1_0 -u 0.0704784218857965 > ./result_6chains/node252_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_0 -p 278 -st none -pt topic252_2_0 -u 0.004058524420678944 > ./result_6chains/node252_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_0 -p 418 -st none -pt topic252_3_0 -u 0.03132650864958894 > ./result_6chains/node252_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_0 -p 456 -st none -pt topic252_4_0 -u 0.01504002503115906 > ./result_6chains/node252_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_0 -p 755 -st none -pt topic252_5_0 -u 0.024871388994132715 > ./result_6chains/node252_5_0.txt &
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
    "./result_6chains/node252_0_0.txt 90"
    "./result_6chains/node252_0_2.txt 90"
    "./result_6chains/node252_1_0.txt 89"
    "./result_6chains/node252_1_2.txt 89"
    "./result_6chains/node252_2_0.txt 88"
    "./result_6chains/node252_2_2.txt 88"
    "./result_6chains/node252_3_0.txt 87"
    "./result_6chains/node252_3_2.txt 87"
    "./result_6chains/node252_4_0.txt 86"
    "./result_6chains/node252_4_2.txt 86"
    "./result_6chains/node252_5_0.txt 85"
    "./result_6chains/node252_5_2.txt 85"
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
