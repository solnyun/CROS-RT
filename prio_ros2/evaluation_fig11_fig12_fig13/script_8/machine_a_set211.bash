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
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_2 -p 318 -st topic211_0_1 -pt None -u 0.006309729397124986 > ./result_8chains/node211_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_2 -p 330 -st topic211_1_1 -pt None -u 0.009135937288899998 > ./result_8chains/node211_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_2 -p 598 -st topic211_2_1 -pt None -u 0.06616005839646366 > ./result_8chains/node211_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_2 -p 697 -st topic211_3_1 -pt None -u 0.0154317194694861 > ./result_8chains/node211_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_2 -p 747 -st topic211_4_1 -pt None -u 0.016446185144823974 > ./result_8chains/node211_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_2 -p 823 -st topic211_5_1 -pt None -u 0.022121902182847236 > ./result_8chains/node211_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_6_2 -p 985 -st topic211_6_1 -pt None -u 0.025002247810099007 > ./result_8chains/node211_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_7_2 -p 999 -st topic211_7_1 -pt None -u 0.0006836717806679179 > ./result_8chains/node211_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_0 -p 318 -st none -pt topic211_0_0 -u 0.06813812005257058 > ./result_8chains/node211_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_0 -p 330 -st none -pt topic211_1_0 -u 0.0559964749966782 > ./result_8chains/node211_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_0 -p 598 -st none -pt topic211_2_0 -u 0.03317455990304308 > ./result_8chains/node211_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_0 -p 697 -st none -pt topic211_3_0 -u 0.03852497854966372 > ./result_8chains/node211_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_0 -p 747 -st none -pt topic211_4_0 -u 0.00628354824315927 > ./result_8chains/node211_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_0 -p 823 -st none -pt topic211_5_0 -u 0.007284679959872725 > ./result_8chains/node211_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_6_0 -p 985 -st none -pt topic211_6_0 -u 0.031055162382550815 > ./result_8chains/node211_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_7_0 -p 999 -st none -pt topic211_7_0 -u 0.002328080989095156 > ./result_8chains/node211_7_0.txt &
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
    "./result_8chains/node211_0_0.txt 90"
    "./result_8chains/node211_0_2.txt 90"
    "./result_8chains/node211_1_0.txt 89"
    "./result_8chains/node211_1_2.txt 89"
    "./result_8chains/node211_2_0.txt 88"
    "./result_8chains/node211_2_2.txt 88"
    "./result_8chains/node211_3_0.txt 87"
    "./result_8chains/node211_3_2.txt 87"
    "./result_8chains/node211_4_0.txt 86"
    "./result_8chains/node211_4_2.txt 86"
    "./result_8chains/node211_5_0.txt 85"
    "./result_8chains/node211_5_2.txt 85"
    "./result_8chains/node211_6_0.txt 84"
    "./result_8chains/node211_6_2.txt 84"
    "./result_8chains/node211_7_0.txt 83"
    "./result_8chains/node211_7_2.txt 83"
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
