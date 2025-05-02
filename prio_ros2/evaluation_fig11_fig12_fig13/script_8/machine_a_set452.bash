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
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_2 -p 72 -st topic452_0_1 -pt None -u 0.0005990966133526121 > ./result_8chains/node452_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_2 -p 440 -st topic452_1_1 -pt None -u 0.023479877774465863 > ./result_8chains/node452_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_2 -p 465 -st topic452_2_1 -pt None -u 0.0040374506906195595 > ./result_8chains/node452_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_2 -p 474 -st topic452_3_1 -pt None -u 0.006435911805961536 > ./result_8chains/node452_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_2 -p 729 -st topic452_4_1 -pt None -u 0.020193846688606437 > ./result_8chains/node452_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_2 -p 756 -st topic452_5_1 -pt None -u 0.05620578077366564 > ./result_8chains/node452_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_2 -p 804 -st topic452_6_1 -pt None -u 0.006574693199732903 > ./result_8chains/node452_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_2 -p 937 -st topic452_7_1 -pt None -u 0.02830590229176898 > ./result_8chains/node452_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_0 -p 72 -st none -pt topic452_0_0 -u 0.021785527972150998 > ./result_8chains/node452_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_0 -p 440 -st none -pt topic452_1_0 -u 0.03664808508465511 > ./result_8chains/node452_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_0 -p 465 -st none -pt topic452_2_0 -u 0.01713233866455416 > ./result_8chains/node452_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_0 -p 474 -st none -pt topic452_3_0 -u 0.011937507910088074 > ./result_8chains/node452_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_0 -p 729 -st none -pt topic452_4_0 -u 0.05139544375141078 > ./result_8chains/node452_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_0 -p 756 -st none -pt topic452_5_0 -u 0.03416162033680126 > ./result_8chains/node452_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_0 -p 804 -st none -pt topic452_6_0 -u 0.015216917184258535 > ./result_8chains/node452_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_0 -p 937 -st none -pt topic452_7_0 -u 0.022640532172689486 > ./result_8chains/node452_7_0.txt &
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
    "./result_8chains/node452_0_0.txt 90"
    "./result_8chains/node452_0_2.txt 90"
    "./result_8chains/node452_1_0.txt 89"
    "./result_8chains/node452_1_2.txt 89"
    "./result_8chains/node452_2_0.txt 88"
    "./result_8chains/node452_2_2.txt 88"
    "./result_8chains/node452_3_0.txt 87"
    "./result_8chains/node452_3_2.txt 87"
    "./result_8chains/node452_4_0.txt 86"
    "./result_8chains/node452_4_2.txt 86"
    "./result_8chains/node452_5_0.txt 85"
    "./result_8chains/node452_5_2.txt 85"
    "./result_8chains/node452_6_0.txt 84"
    "./result_8chains/node452_6_2.txt 84"
    "./result_8chains/node452_7_0.txt 83"
    "./result_8chains/node452_7_2.txt 83"
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
