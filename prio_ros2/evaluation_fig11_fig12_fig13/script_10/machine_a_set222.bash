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
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_2 -p 243 -st topic222_0_1 -pt None -u 0.0003245521780074201 > ./result_10chains/node222_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_2 -p 286 -st topic222_1_1 -pt None -u 0.01820872785290173 > ./result_10chains/node222_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_2 -p 335 -st topic222_2_1 -pt None -u 0.03231805484113448 > ./result_10chains/node222_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_2 -p 442 -st topic222_3_1 -pt None -u 0.0038455006127249836 > ./result_10chains/node222_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_2 -p 481 -st topic222_4_1 -pt None -u 0.018821483642648157 > ./result_10chains/node222_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_2 -p 510 -st topic222_5_1 -pt None -u 0.014831453440869308 > ./result_10chains/node222_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_6_2 -p 677 -st topic222_6_1 -pt None -u 0.018839071152851036 > ./result_10chains/node222_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_7_2 -p 759 -st topic222_7_1 -pt None -u 0.029222803956906254 > ./result_10chains/node222_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_8_2 -p 936 -st topic222_8_1 -pt None -u 0.009896079973515971 > ./result_10chains/node222_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_9_2 -p 965 -st topic222_9_1 -pt None -u 0.0026175327413251273 > ./result_10chains/node222_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_0 -p 243 -st none -pt topic222_0_0 -u 0.005427527317300285 > ./result_10chains/node222_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_0 -p 286 -st none -pt topic222_1_0 -u 0.008843263658166012 > ./result_10chains/node222_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_0 -p 335 -st none -pt topic222_2_0 -u 0.04357567898055709 > ./result_10chains/node222_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_0 -p 442 -st none -pt topic222_3_0 -u 0.001222098575475672 > ./result_10chains/node222_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_0 -p 481 -st none -pt topic222_4_0 -u 0.02872586852736636 > ./result_10chains/node222_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_0 -p 510 -st none -pt topic222_5_0 -u 0.00941594714979821 > ./result_10chains/node222_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_6_0 -p 677 -st none -pt topic222_6_0 -u 0.008016924744539827 > ./result_10chains/node222_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_7_0 -p 759 -st none -pt topic222_7_0 -u 0.0011396338663450245 > ./result_10chains/node222_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_8_0 -p 936 -st none -pt topic222_8_0 -u 0.0033828174788553753 > ./result_10chains/node222_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_9_0 -p 965 -st none -pt topic222_9_0 -u 0.01632162748664826 > ./result_10chains/node222_9_0.txt &
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
    "./result_10chains/node222_0_0.txt 90"
    "./result_10chains/node222_0_2.txt 90"
    "./result_10chains/node222_1_0.txt 89"
    "./result_10chains/node222_1_2.txt 89"
    "./result_10chains/node222_2_0.txt 88"
    "./result_10chains/node222_2_2.txt 88"
    "./result_10chains/node222_3_0.txt 87"
    "./result_10chains/node222_3_2.txt 87"
    "./result_10chains/node222_4_0.txt 86"
    "./result_10chains/node222_4_2.txt 86"
    "./result_10chains/node222_5_0.txt 85"
    "./result_10chains/node222_5_2.txt 85"
    "./result_10chains/node222_6_0.txt 84"
    "./result_10chains/node222_6_2.txt 84"
    "./result_10chains/node222_7_0.txt 83"
    "./result_10chains/node222_7_2.txt 83"
    "./result_10chains/node222_8_0.txt 82"
    "./result_10chains/node222_8_2.txt 82"
    "./result_10chains/node222_9_0.txt 81"
    "./result_10chains/node222_9_2.txt 81"
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
