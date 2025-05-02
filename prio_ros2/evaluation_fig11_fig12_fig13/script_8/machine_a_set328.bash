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
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_2 -p 461 -st topic328_0_1 -pt None -u 0.010160594838583614 > ./result_8chains/node328_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_2 -p 477 -st topic328_1_1 -pt None -u 0.06087982944131698 > ./result_8chains/node328_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_2 -p 562 -st topic328_2_1 -pt None -u 0.035479085366795005 > ./result_8chains/node328_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_2 -p 647 -st topic328_3_1 -pt None -u 0.021990321146670128 > ./result_8chains/node328_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_2 -p 689 -st topic328_4_1 -pt None -u 0.009734568893797563 > ./result_8chains/node328_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_2 -p 699 -st topic328_5_1 -pt None -u 0.004289938499534449 > ./result_8chains/node328_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_2 -p 720 -st topic328_6_1 -pt None -u 0.03651295711242599 > ./result_8chains/node328_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_2 -p 949 -st topic328_7_1 -pt None -u 0.018639191844871686 > ./result_8chains/node328_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_0 -p 461 -st none -pt topic328_0_0 -u 0.003386168396736444 > ./result_8chains/node328_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_0 -p 477 -st none -pt topic328_1_0 -u 0.009124994679900189 > ./result_8chains/node328_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_0 -p 562 -st none -pt topic328_2_0 -u 0.044326144095724995 > ./result_8chains/node328_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_0 -p 647 -st none -pt topic328_3_0 -u 0.008836109589981267 > ./result_8chains/node328_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_0 -p 689 -st none -pt topic328_4_0 -u 0.013380662526758486 > ./result_8chains/node328_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_0 -p 699 -st none -pt topic328_5_0 -u 0.030701652543777075 > ./result_8chains/node328_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_0 -p 720 -st none -pt topic328_6_0 -u 0.00892749007324424 > ./result_8chains/node328_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_0 -p 949 -st none -pt topic328_7_0 -u 0.004916685348756257 > ./result_8chains/node328_7_0.txt &
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
    "./result_8chains/node328_0_0.txt 90"
    "./result_8chains/node328_0_2.txt 90"
    "./result_8chains/node328_1_0.txt 89"
    "./result_8chains/node328_1_2.txt 89"
    "./result_8chains/node328_2_0.txt 88"
    "./result_8chains/node328_2_2.txt 88"
    "./result_8chains/node328_3_0.txt 87"
    "./result_8chains/node328_3_2.txt 87"
    "./result_8chains/node328_4_0.txt 86"
    "./result_8chains/node328_4_2.txt 86"
    "./result_8chains/node328_5_0.txt 85"
    "./result_8chains/node328_5_2.txt 85"
    "./result_8chains/node328_6_0.txt 84"
    "./result_8chains/node328_6_2.txt 84"
    "./result_8chains/node328_7_0.txt 83"
    "./result_8chains/node328_7_2.txt 83"
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
