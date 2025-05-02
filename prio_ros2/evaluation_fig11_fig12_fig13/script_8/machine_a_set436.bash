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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_2 -p 62 -st topic436_0_1 -pt None -u 0.03156052004937654 > ./result_8chains/node436_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_2 -p 173 -st topic436_1_1 -pt None -u 0.0027529637351020875 > ./result_8chains/node436_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_2 -p 238 -st topic436_2_1 -pt None -u 0.026593404412845856 > ./result_8chains/node436_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_2 -p 488 -st topic436_3_1 -pt None -u 0.02406386169306568 > ./result_8chains/node436_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_2 -p 562 -st topic436_4_1 -pt None -u 0.007015152597240296 > ./result_8chains/node436_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_2 -p 874 -st topic436_5_1 -pt None -u 0.00990095263033651 > ./result_8chains/node436_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_2 -p 931 -st topic436_6_1 -pt None -u 0.004939411410913398 > ./result_8chains/node436_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_2 -p 972 -st topic436_7_1 -pt None -u 0.03519901863666702 > ./result_8chains/node436_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_0 -p 62 -st none -pt topic436_0_0 -u 0.04816987486047081 > ./result_8chains/node436_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_0 -p 173 -st none -pt topic436_1_0 -u 0.013648734617022373 > ./result_8chains/node436_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_0 -p 238 -st none -pt topic436_2_0 -u 0.0006210610953870099 > ./result_8chains/node436_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_0 -p 488 -st none -pt topic436_3_0 -u 0.03426677780749157 > ./result_8chains/node436_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_0 -p 562 -st none -pt topic436_4_0 -u 0.024579645612486628 > ./result_8chains/node436_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_0 -p 874 -st none -pt topic436_5_0 -u 0.03345625008789284 > ./result_8chains/node436_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_0 -p 931 -st none -pt topic436_6_0 -u 0.006852640957423828 > ./result_8chains/node436_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_0 -p 972 -st none -pt topic436_7_0 -u 0.002765451180709373 > ./result_8chains/node436_7_0.txt &
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
    "./result_8chains/node436_0_0.txt 90"
    "./result_8chains/node436_0_2.txt 90"
    "./result_8chains/node436_1_0.txt 89"
    "./result_8chains/node436_1_2.txt 89"
    "./result_8chains/node436_2_0.txt 88"
    "./result_8chains/node436_2_2.txt 88"
    "./result_8chains/node436_3_0.txt 87"
    "./result_8chains/node436_3_2.txt 87"
    "./result_8chains/node436_4_0.txt 86"
    "./result_8chains/node436_4_2.txt 86"
    "./result_8chains/node436_5_0.txt 85"
    "./result_8chains/node436_5_2.txt 85"
    "./result_8chains/node436_6_0.txt 84"
    "./result_8chains/node436_6_2.txt 84"
    "./result_8chains/node436_7_0.txt 83"
    "./result_8chains/node436_7_2.txt 83"
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
