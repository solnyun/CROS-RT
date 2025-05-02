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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_2 -p 95 -st topic357_0_1 -pt None -u 0.008856934386144266 > ./result_8chains/node357_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_2 -p 264 -st topic357_1_1 -pt None -u 0.007314845716125895 > ./result_8chains/node357_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_2 -p 618 -st topic357_2_1 -pt None -u 0.037246271477267334 > ./result_8chains/node357_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_2 -p 637 -st topic357_3_1 -pt None -u 0.08278871724514383 > ./result_8chains/node357_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_2 -p 803 -st topic357_4_1 -pt None -u 0.008351826827822678 > ./result_8chains/node357_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_2 -p 805 -st topic357_5_1 -pt None -u 6.932650513702399e-05 > ./result_8chains/node357_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_2 -p 865 -st topic357_6_1 -pt None -u 0.02034328512096407 > ./result_8chains/node357_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_2 -p 873 -st topic357_7_1 -pt None -u 0.009449843049227795 > ./result_8chains/node357_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_0 -p 95 -st none -pt topic357_0_0 -u 0.01922255235634779 > ./result_8chains/node357_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_0 -p 264 -st none -pt topic357_1_0 -u 0.030066118522525886 > ./result_8chains/node357_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_0 -p 618 -st none -pt topic357_2_0 -u 0.007004028230322978 > ./result_8chains/node357_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_0 -p 637 -st none -pt topic357_3_0 -u 0.02402008468381639 > ./result_8chains/node357_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_0 -p 803 -st none -pt topic357_4_0 -u 0.002612184377634691 > ./result_8chains/node357_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_0 -p 805 -st none -pt topic357_5_0 -u 0.005526109759139308 > ./result_8chains/node357_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_0 -p 865 -st none -pt topic357_6_0 -u 0.03624018655010745 > ./result_8chains/node357_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_0 -p 873 -st none -pt topic357_7_0 -u 0.0026429209831129313 > ./result_8chains/node357_7_0.txt &
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
    "./result_8chains/node357_0_0.txt 90"
    "./result_8chains/node357_0_2.txt 90"
    "./result_8chains/node357_1_0.txt 89"
    "./result_8chains/node357_1_2.txt 89"
    "./result_8chains/node357_2_0.txt 88"
    "./result_8chains/node357_2_2.txt 88"
    "./result_8chains/node357_3_0.txt 87"
    "./result_8chains/node357_3_2.txt 87"
    "./result_8chains/node357_4_0.txt 86"
    "./result_8chains/node357_4_2.txt 86"
    "./result_8chains/node357_5_0.txt 85"
    "./result_8chains/node357_5_2.txt 85"
    "./result_8chains/node357_6_0.txt 84"
    "./result_8chains/node357_6_2.txt 84"
    "./result_8chains/node357_7_0.txt 83"
    "./result_8chains/node357_7_2.txt 83"
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
