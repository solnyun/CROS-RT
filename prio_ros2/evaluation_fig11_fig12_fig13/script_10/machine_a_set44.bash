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
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_2 -p 34 -st topic44_0_1 -pt None -u 0.002209642589308558 > ./result_10chains/node44_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_2 -p 140 -st topic44_1_1 -pt None -u 0.025475154054932447 > ./result_10chains/node44_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_2 -p 387 -st topic44_2_1 -pt None -u 0.015854502214611543 > ./result_10chains/node44_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_2 -p 403 -st topic44_3_1 -pt None -u 0.02286613919739164 > ./result_10chains/node44_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_2 -p 680 -st topic44_4_1 -pt None -u 0.0147533827034253 > ./result_10chains/node44_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_2 -p 743 -st topic44_5_1 -pt None -u 0.009566119880245083 > ./result_10chains/node44_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_6_2 -p 795 -st topic44_6_1 -pt None -u 0.016116838411553383 > ./result_10chains/node44_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_7_2 -p 845 -st topic44_7_1 -pt None -u 0.02803656341347094 > ./result_10chains/node44_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_8_2 -p 939 -st topic44_8_1 -pt None -u 0.0007561413892465951 > ./result_10chains/node44_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_9_2 -p 949 -st topic44_9_1 -pt None -u 0.03336349725017157 > ./result_10chains/node44_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_0 -p 34 -st none -pt topic44_0_0 -u 0.003751668151935894 > ./result_10chains/node44_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_0 -p 140 -st none -pt topic44_1_0 -u 0.02365719478552264 > ./result_10chains/node44_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_0 -p 387 -st none -pt topic44_2_0 -u 0.0059498659311447155 > ./result_10chains/node44_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_0 -p 403 -st none -pt topic44_3_0 -u 0.023261493379005238 > ./result_10chains/node44_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_0 -p 680 -st none -pt topic44_4_0 -u 0.03210583459561034 > ./result_10chains/node44_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_0 -p 743 -st none -pt topic44_5_0 -u 0.003102109553481669 > ./result_10chains/node44_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_6_0 -p 795 -st none -pt topic44_6_0 -u 0.02600860311540998 > ./result_10chains/node44_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_7_0 -p 845 -st none -pt topic44_7_0 -u 0.0006775741036173094 > ./result_10chains/node44_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_8_0 -p 939 -st none -pt topic44_8_0 -u 0.0012537461156302554 > ./result_10chains/node44_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_9_0 -p 949 -st none -pt topic44_9_0 -u 0.023150611292308852 > ./result_10chains/node44_9_0.txt &
sleep 10
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
    "./result_10chains/node44_0_0.txt 90"
    "./result_10chains/node44_0_2.txt 90"
    "./result_10chains/node44_1_0.txt 89"
    "./result_10chains/node44_1_2.txt 89"
    "./result_10chains/node44_2_0.txt 88"
    "./result_10chains/node44_2_2.txt 88"
    "./result_10chains/node44_3_0.txt 87"
    "./result_10chains/node44_3_2.txt 87"
    "./result_10chains/node44_4_0.txt 86"
    "./result_10chains/node44_4_2.txt 86"
    "./result_10chains/node44_5_0.txt 85"
    "./result_10chains/node44_5_2.txt 85"
    "./result_10chains/node44_6_0.txt 84"
    "./result_10chains/node44_6_2.txt 84"
    "./result_10chains/node44_7_0.txt 83"
    "./result_10chains/node44_7_2.txt 83"
    "./result_10chains/node44_8_0.txt 82"
    "./result_10chains/node44_8_2.txt 82"
    "./result_10chains/node44_9_0.txt 81"
    "./result_10chains/node44_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
