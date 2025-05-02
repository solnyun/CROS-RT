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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_2 -p 119 -st topic410_0_1 -pt None -u 0.002156254235762156 > ./result_8chains/node410_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_2 -p 173 -st topic410_1_1 -pt None -u 0.010949555009692191 > ./result_8chains/node410_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_2 -p 241 -st topic410_2_1 -pt None -u 0.052923574256665606 > ./result_8chains/node410_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_2 -p 583 -st topic410_3_1 -pt None -u 0.06760154467998947 > ./result_8chains/node410_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_2 -p 586 -st topic410_4_1 -pt None -u 0.006493963000656772 > ./result_8chains/node410_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_2 -p 649 -st topic410_5_1 -pt None -u 0.04013851182561193 > ./result_8chains/node410_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_2 -p 690 -st topic410_6_1 -pt None -u 0.007011502942419395 > ./result_8chains/node410_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_2 -p 853 -st topic410_7_1 -pt None -u 0.022282385144630653 > ./result_8chains/node410_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_0 -p 119 -st none -pt topic410_0_0 -u 0.011946614034739678 > ./result_8chains/node410_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_0 -p 173 -st none -pt topic410_1_0 -u 0.0021919554045098932 > ./result_8chains/node410_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_0 -p 241 -st none -pt topic410_2_0 -u 0.00325874707196544 > ./result_8chains/node410_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_0 -p 583 -st none -pt topic410_3_0 -u 0.018884327037039794 > ./result_8chains/node410_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_0 -p 586 -st none -pt topic410_4_0 -u 0.020423153056607274 > ./result_8chains/node410_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_0 -p 649 -st none -pt topic410_5_0 -u 0.005239025726079205 > ./result_8chains/node410_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_0 -p 690 -st none -pt topic410_6_0 -u 0.009958287905717358 > ./result_8chains/node410_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_0 -p 853 -st none -pt topic410_7_0 -u 0.003264615900127152 > ./result_8chains/node410_7_0.txt &
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
    "./result_8chains/node410_0_0.txt 90"
    "./result_8chains/node410_0_2.txt 90"
    "./result_8chains/node410_1_0.txt 89"
    "./result_8chains/node410_1_2.txt 89"
    "./result_8chains/node410_2_0.txt 88"
    "./result_8chains/node410_2_2.txt 88"
    "./result_8chains/node410_3_0.txt 87"
    "./result_8chains/node410_3_2.txt 87"
    "./result_8chains/node410_4_0.txt 86"
    "./result_8chains/node410_4_2.txt 86"
    "./result_8chains/node410_5_0.txt 85"
    "./result_8chains/node410_5_2.txt 85"
    "./result_8chains/node410_6_0.txt 84"
    "./result_8chains/node410_6_2.txt 84"
    "./result_8chains/node410_7_0.txt 83"
    "./result_8chains/node410_7_2.txt 83"
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
