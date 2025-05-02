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
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_2 -p 122 -st topic405_0_1 -pt None -u 0.11037606266687222 > ./result_8chains/node405_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_2 -p 222 -st topic405_1_1 -pt None -u 0.053196293457230315 > ./result_8chains/node405_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_2 -p 343 -st topic405_2_1 -pt None -u 0.01569448909308041 > ./result_8chains/node405_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_2 -p 431 -st topic405_3_1 -pt None -u 0.01115032161276111 > ./result_8chains/node405_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_2 -p 503 -st topic405_4_1 -pt None -u 0.0019074037053766757 > ./result_8chains/node405_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_2 -p 564 -st topic405_5_1 -pt None -u 0.018352274712731015 > ./result_8chains/node405_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_6_2 -p 711 -st topic405_6_1 -pt None -u 0.0031293574464244175 > ./result_8chains/node405_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_7_2 -p 922 -st topic405_7_1 -pt None -u 0.006361144477592179 > ./result_8chains/node405_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_0 -p 122 -st none -pt topic405_0_0 -u 0.0077364951515244695 > ./result_8chains/node405_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_0 -p 222 -st none -pt topic405_1_0 -u 0.01066614258542592 > ./result_8chains/node405_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_0 -p 343 -st none -pt topic405_2_0 -u 0.0037304629482147744 > ./result_8chains/node405_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_0 -p 431 -st none -pt topic405_3_0 -u 0.00020909025138188264 > ./result_8chains/node405_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_0 -p 503 -st none -pt topic405_4_0 -u 0.001236716315918679 > ./result_8chains/node405_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_0 -p 564 -st none -pt topic405_5_0 -u 0.010844302795926297 > ./result_8chains/node405_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_6_0 -p 711 -st none -pt topic405_6_0 -u 0.020338345504608488 > ./result_8chains/node405_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_7_0 -p 922 -st none -pt topic405_7_0 -u 0.005226476324967831 > ./result_8chains/node405_7_0.txt &
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
    "./result_8chains/node405_0_0.txt 90"
    "./result_8chains/node405_0_2.txt 90"
    "./result_8chains/node405_1_0.txt 89"
    "./result_8chains/node405_1_2.txt 89"
    "./result_8chains/node405_2_0.txt 88"
    "./result_8chains/node405_2_2.txt 88"
    "./result_8chains/node405_3_0.txt 87"
    "./result_8chains/node405_3_2.txt 87"
    "./result_8chains/node405_4_0.txt 86"
    "./result_8chains/node405_4_2.txt 86"
    "./result_8chains/node405_5_0.txt 85"
    "./result_8chains/node405_5_2.txt 85"
    "./result_8chains/node405_6_0.txt 84"
    "./result_8chains/node405_6_2.txt 84"
    "./result_8chains/node405_7_0.txt 83"
    "./result_8chains/node405_7_2.txt 83"
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
