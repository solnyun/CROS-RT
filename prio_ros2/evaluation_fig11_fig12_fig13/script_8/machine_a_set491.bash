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
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_2 -p 35 -st topic491_0_1 -pt None -u 0.11821119352457043 > ./result_8chains/node491_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_2 -p 99 -st topic491_1_1 -pt None -u 0.025792939760052536 > ./result_8chains/node491_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_2 -p 232 -st topic491_2_1 -pt None -u 0.0012521349190540154 > ./result_8chains/node491_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_2 -p 245 -st topic491_3_1 -pt None -u 0.003547455089972007 > ./result_8chains/node491_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_2 -p 523 -st topic491_4_1 -pt None -u 0.02754205674000973 > ./result_8chains/node491_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_2 -p 539 -st topic491_5_1 -pt None -u 0.006679440874559281 > ./result_8chains/node491_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_6_2 -p 623 -st topic491_6_1 -pt None -u 0.006120142679327006 > ./result_8chains/node491_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_7_2 -p 964 -st topic491_7_1 -pt None -u 0.002088812131976876 > ./result_8chains/node491_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_0_0 -p 35 -st none -pt topic491_0_0 -u 0.010508656903395142 > ./result_8chains/node491_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_1_0 -p 99 -st none -pt topic491_1_0 -u 0.017337508066572804 > ./result_8chains/node491_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_2_0 -p 232 -st none -pt topic491_2_0 -u 0.01577992240622758 > ./result_8chains/node491_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_3_0 -p 245 -st none -pt topic491_3_0 -u 0.009712405223432946 > ./result_8chains/node491_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_4_0 -p 523 -st none -pt topic491_4_0 -u 0.01923922033560241 > ./result_8chains/node491_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_5_0 -p 539 -st none -pt topic491_5_0 -u 0.008098891216453949 > ./result_8chains/node491_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node491_6_0 -p 623 -st none -pt topic491_6_0 -u 0.005004172573879334 > ./result_8chains/node491_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node491_7_0 -p 964 -st none -pt topic491_7_0 -u 0.006238214781794399 > ./result_8chains/node491_7_0.txt &
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
    "./result_8chains/node491_0_0.txt 90"
    "./result_8chains/node491_0_2.txt 90"
    "./result_8chains/node491_1_0.txt 89"
    "./result_8chains/node491_1_2.txt 89"
    "./result_8chains/node491_2_0.txt 88"
    "./result_8chains/node491_2_2.txt 88"
    "./result_8chains/node491_3_0.txt 87"
    "./result_8chains/node491_3_2.txt 87"
    "./result_8chains/node491_4_0.txt 86"
    "./result_8chains/node491_4_2.txt 86"
    "./result_8chains/node491_5_0.txt 85"
    "./result_8chains/node491_5_2.txt 85"
    "./result_8chains/node491_6_0.txt 84"
    "./result_8chains/node491_6_2.txt 84"
    "./result_8chains/node491_7_0.txt 83"
    "./result_8chains/node491_7_2.txt 83"
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
