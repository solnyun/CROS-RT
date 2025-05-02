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
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_2 -p 198 -st topic367_0_1 -pt None -u 0.009510546385288199 > ./result_8chains/node367_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_2 -p 386 -st topic367_1_1 -pt None -u 0.11494576269630119 > ./result_8chains/node367_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_2 -p 439 -st topic367_2_1 -pt None -u 0.010658079194369618 > ./result_8chains/node367_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_2 -p 441 -st topic367_3_1 -pt None -u 0.006278004537675408 > ./result_8chains/node367_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_2 -p 558 -st topic367_4_1 -pt None -u 0.010900183335023489 > ./result_8chains/node367_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_2 -p 803 -st topic367_5_1 -pt None -u 0.01146143818687323 > ./result_8chains/node367_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_6_2 -p 905 -st topic367_6_1 -pt None -u 0.06545885857691026 > ./result_8chains/node367_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_7_2 -p 939 -st topic367_7_1 -pt None -u 0.004548652532525687 > ./result_8chains/node367_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_0 -p 198 -st none -pt topic367_0_0 -u 0.0016299125374070744 > ./result_8chains/node367_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_0 -p 386 -st none -pt topic367_1_0 -u 0.008723379070695425 > ./result_8chains/node367_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_0 -p 439 -st none -pt topic367_2_0 -u 0.008300811263541541 > ./result_8chains/node367_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_0 -p 441 -st none -pt topic367_3_0 -u 0.03831221664061954 > ./result_8chains/node367_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_0 -p 558 -st none -pt topic367_4_0 -u 0.04561554593429232 > ./result_8chains/node367_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_0 -p 803 -st none -pt topic367_5_0 -u 0.005301249979397932 > ./result_8chains/node367_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_6_0 -p 905 -st none -pt topic367_6_0 -u 0.01796733737117752 > ./result_8chains/node367_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_7_0 -p 939 -st none -pt topic367_7_0 -u 0.02995665909802509 > ./result_8chains/node367_7_0.txt &
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
    "./result_8chains/node367_0_0.txt 90"
    "./result_8chains/node367_0_2.txt 90"
    "./result_8chains/node367_1_0.txt 89"
    "./result_8chains/node367_1_2.txt 89"
    "./result_8chains/node367_2_0.txt 88"
    "./result_8chains/node367_2_2.txt 88"
    "./result_8chains/node367_3_0.txt 87"
    "./result_8chains/node367_3_2.txt 87"
    "./result_8chains/node367_4_0.txt 86"
    "./result_8chains/node367_4_2.txt 86"
    "./result_8chains/node367_5_0.txt 85"
    "./result_8chains/node367_5_2.txt 85"
    "./result_8chains/node367_6_0.txt 84"
    "./result_8chains/node367_6_2.txt 84"
    "./result_8chains/node367_7_0.txt 83"
    "./result_8chains/node367_7_2.txt 83"
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
