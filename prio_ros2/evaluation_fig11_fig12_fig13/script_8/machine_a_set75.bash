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
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_2 -p 210 -st topic75_0_1 -pt None -u 0.06586940494451149 > ./result_8chains/node75_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_2 -p 227 -st topic75_1_1 -pt None -u 0.006227313416593605 > ./result_8chains/node75_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_2 -p 326 -st topic75_2_1 -pt None -u 0.027737800958519243 > ./result_8chains/node75_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_2 -p 406 -st topic75_3_1 -pt None -u 0.009040049443123227 > ./result_8chains/node75_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_2 -p 434 -st topic75_4_1 -pt None -u 0.028682670404623994 > ./result_8chains/node75_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_2 -p 736 -st topic75_5_1 -pt None -u 0.007137975723300161 > ./result_8chains/node75_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_2 -p 820 -st topic75_6_1 -pt None -u 0.0068348569935580555 > ./result_8chains/node75_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_2 -p 845 -st topic75_7_1 -pt None -u 0.023774422641100693 > ./result_8chains/node75_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_0 -p 210 -st none -pt topic75_0_0 -u 0.0045266318484519785 > ./result_8chains/node75_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_0 -p 227 -st none -pt topic75_1_0 -u 0.02458585987413553 > ./result_8chains/node75_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_0 -p 326 -st none -pt topic75_2_0 -u 0.07173977925761277 > ./result_8chains/node75_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_0 -p 406 -st none -pt topic75_3_0 -u 0.006772812795024147 > ./result_8chains/node75_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_0 -p 434 -st none -pt topic75_4_0 -u 0.008932234526388638 > ./result_8chains/node75_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_0 -p 736 -st none -pt topic75_5_0 -u 0.0636580762178022 > ./result_8chains/node75_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_0 -p 820 -st none -pt topic75_6_0 -u 0.005264761135013132 > ./result_8chains/node75_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_0 -p 845 -st none -pt topic75_7_0 -u 0.0014822507137981812 > ./result_8chains/node75_7_0.txt &
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
    "./result_8chains/node75_0_0.txt 90"
    "./result_8chains/node75_0_2.txt 90"
    "./result_8chains/node75_1_0.txt 89"
    "./result_8chains/node75_1_2.txt 89"
    "./result_8chains/node75_2_0.txt 88"
    "./result_8chains/node75_2_2.txt 88"
    "./result_8chains/node75_3_0.txt 87"
    "./result_8chains/node75_3_2.txt 87"
    "./result_8chains/node75_4_0.txt 86"
    "./result_8chains/node75_4_2.txt 86"
    "./result_8chains/node75_5_0.txt 85"
    "./result_8chains/node75_5_2.txt 85"
    "./result_8chains/node75_6_0.txt 84"
    "./result_8chains/node75_6_2.txt 84"
    "./result_8chains/node75_7_0.txt 83"
    "./result_8chains/node75_7_2.txt 83"
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
