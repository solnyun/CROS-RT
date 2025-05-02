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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_2 -p 81 -st topic171_0_1 -pt None -u 0.0012891047693948665 > ./result_8chains/node171_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_2 -p 199 -st topic171_1_1 -pt None -u 0.06674929660617757 > ./result_8chains/node171_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_2 -p 272 -st topic171_2_1 -pt None -u 0.01256991741724045 > ./result_8chains/node171_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_2 -p 424 -st topic171_3_1 -pt None -u 0.08285163137499926 > ./result_8chains/node171_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_2 -p 479 -st topic171_4_1 -pt None -u 0.019635735345173308 > ./result_8chains/node171_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_2 -p 669 -st topic171_5_1 -pt None -u 0.014179922099900849 > ./result_8chains/node171_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_2 -p 712 -st topic171_6_1 -pt None -u 0.005982164435836736 > ./result_8chains/node171_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_2 -p 772 -st topic171_7_1 -pt None -u 0.0005537597708920153 > ./result_8chains/node171_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_0 -p 81 -st none -pt topic171_0_0 -u 0.014807228834698205 > ./result_8chains/node171_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_0 -p 199 -st none -pt topic171_1_0 -u 0.006837737573978653 > ./result_8chains/node171_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_0 -p 272 -st none -pt topic171_2_0 -u 0.025593816260912394 > ./result_8chains/node171_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_0 -p 424 -st none -pt topic171_3_0 -u 0.0031744026368650813 > ./result_8chains/node171_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_0 -p 479 -st none -pt topic171_4_0 -u 0.03689740001797259 > ./result_8chains/node171_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_0 -p 669 -st none -pt topic171_5_0 -u 0.027617392482363168 > ./result_8chains/node171_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_0 -p 712 -st none -pt topic171_6_0 -u 0.004823014879192851 > ./result_8chains/node171_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_0 -p 772 -st none -pt topic171_7_0 -u 0.004504230478025145 > ./result_8chains/node171_7_0.txt &
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
    "./result_8chains/node171_0_0.txt 90"
    "./result_8chains/node171_0_2.txt 90"
    "./result_8chains/node171_1_0.txt 89"
    "./result_8chains/node171_1_2.txt 89"
    "./result_8chains/node171_2_0.txt 88"
    "./result_8chains/node171_2_2.txt 88"
    "./result_8chains/node171_3_0.txt 87"
    "./result_8chains/node171_3_2.txt 87"
    "./result_8chains/node171_4_0.txt 86"
    "./result_8chains/node171_4_2.txt 86"
    "./result_8chains/node171_5_0.txt 85"
    "./result_8chains/node171_5_2.txt 85"
    "./result_8chains/node171_6_0.txt 84"
    "./result_8chains/node171_6_2.txt 84"
    "./result_8chains/node171_7_0.txt 83"
    "./result_8chains/node171_7_2.txt 83"
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
