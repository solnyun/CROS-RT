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
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_2 -p 213 -st topic415_0_1 -pt None -u 0.08926009498523457 > ./result_8chains/node415_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_2 -p 285 -st topic415_1_1 -pt None -u 0.014857807399086875 > ./result_8chains/node415_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_2 -p 293 -st topic415_2_1 -pt None -u 0.001151851149004235 > ./result_8chains/node415_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_2 -p 410 -st topic415_3_1 -pt None -u 0.0017073991852936676 > ./result_8chains/node415_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_2 -p 544 -st topic415_4_1 -pt None -u 0.024579201187319183 > ./result_8chains/node415_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_2 -p 563 -st topic415_5_1 -pt None -u 0.008820885073528628 > ./result_8chains/node415_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_6_2 -p 717 -st topic415_6_1 -pt None -u 0.03572766631929415 > ./result_8chains/node415_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_7_2 -p 886 -st topic415_7_1 -pt None -u 0.022595175694713015 > ./result_8chains/node415_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_0 -p 213 -st none -pt topic415_0_0 -u 0.004267462073901496 > ./result_8chains/node415_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_0 -p 285 -st none -pt topic415_1_0 -u 0.0031157397067420045 > ./result_8chains/node415_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_0 -p 293 -st none -pt topic415_2_0 -u 0.04306127153178951 > ./result_8chains/node415_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_0 -p 410 -st none -pt topic415_3_0 -u 0.03579713512960522 > ./result_8chains/node415_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_0 -p 544 -st none -pt topic415_4_0 -u 0.012244635931362463 > ./result_8chains/node415_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_0 -p 563 -st none -pt topic415_5_0 -u 0.010195942164916622 > ./result_8chains/node415_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_6_0 -p 717 -st none -pt topic415_6_0 -u 0.0005414663129666708 > ./result_8chains/node415_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_7_0 -p 886 -st none -pt topic415_7_0 -u 0.048649687364991076 > ./result_8chains/node415_7_0.txt &
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
    "./result_8chains/node415_0_0.txt 90"
    "./result_8chains/node415_0_2.txt 90"
    "./result_8chains/node415_1_0.txt 89"
    "./result_8chains/node415_1_2.txt 89"
    "./result_8chains/node415_2_0.txt 88"
    "./result_8chains/node415_2_2.txt 88"
    "./result_8chains/node415_3_0.txt 87"
    "./result_8chains/node415_3_2.txt 87"
    "./result_8chains/node415_4_0.txt 86"
    "./result_8chains/node415_4_2.txt 86"
    "./result_8chains/node415_5_0.txt 85"
    "./result_8chains/node415_5_2.txt 85"
    "./result_8chains/node415_6_0.txt 84"
    "./result_8chains/node415_6_2.txt 84"
    "./result_8chains/node415_7_0.txt 83"
    "./result_8chains/node415_7_2.txt 83"
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
