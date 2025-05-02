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
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_2 -p 25 -st topic303_0_1 -pt None -u 0.027598912009257293 > ./result_8chains/node303_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_2 -p 41 -st topic303_1_1 -pt None -u 0.012329785800040627 > ./result_8chains/node303_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_2 -p 190 -st topic303_2_1 -pt None -u 0.025530906783844454 > ./result_8chains/node303_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_2 -p 369 -st topic303_3_1 -pt None -u 0.008580130108159584 > ./result_8chains/node303_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_2 -p 516 -st topic303_4_1 -pt None -u 0.002001432995447555 > ./result_8chains/node303_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_2 -p 539 -st topic303_5_1 -pt None -u 0.0730668876206548 > ./result_8chains/node303_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_2 -p 683 -st topic303_6_1 -pt None -u 0.022928562970023304 > ./result_8chains/node303_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_2 -p 738 -st topic303_7_1 -pt None -u 0.010660061421573736 > ./result_8chains/node303_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_0 -p 25 -st none -pt topic303_0_0 -u 0.035658435717880244 > ./result_8chains/node303_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_0 -p 41 -st none -pt topic303_1_0 -u 0.009885972902963558 > ./result_8chains/node303_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_0 -p 190 -st none -pt topic303_2_0 -u 0.027795380648678814 > ./result_8chains/node303_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_0 -p 369 -st none -pt topic303_3_0 -u 0.058616703303495776 > ./result_8chains/node303_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_0 -p 516 -st none -pt topic303_4_0 -u 0.021000601301821964 > ./result_8chains/node303_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_0 -p 539 -st none -pt topic303_5_0 -u 0.02947400664719832 > ./result_8chains/node303_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_6_0 -p 683 -st none -pt topic303_6_0 -u 0.01724467725177098 > ./result_8chains/node303_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_7_0 -p 738 -st none -pt topic303_7_0 -u 0.004456288970411157 > ./result_8chains/node303_7_0.txt &
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
    "./result_8chains/node303_0_0.txt 90"
    "./result_8chains/node303_0_2.txt 90"
    "./result_8chains/node303_1_0.txt 89"
    "./result_8chains/node303_1_2.txt 89"
    "./result_8chains/node303_2_0.txt 88"
    "./result_8chains/node303_2_2.txt 88"
    "./result_8chains/node303_3_0.txt 87"
    "./result_8chains/node303_3_2.txt 87"
    "./result_8chains/node303_4_0.txt 86"
    "./result_8chains/node303_4_2.txt 86"
    "./result_8chains/node303_5_0.txt 85"
    "./result_8chains/node303_5_2.txt 85"
    "./result_8chains/node303_6_0.txt 84"
    "./result_8chains/node303_6_2.txt 84"
    "./result_8chains/node303_7_0.txt 83"
    "./result_8chains/node303_7_2.txt 83"
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
