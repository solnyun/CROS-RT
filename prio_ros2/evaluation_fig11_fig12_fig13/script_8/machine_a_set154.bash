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
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_2 -p 119 -st topic154_0_1 -pt None -u 0.001747909995937269 > ./result_8chains/node154_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_2 -p 157 -st topic154_1_1 -pt None -u 0.014838520099354602 > ./result_8chains/node154_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_2 -p 409 -st topic154_2_1 -pt None -u 0.018206040447580174 > ./result_8chains/node154_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_2 -p 548 -st topic154_3_1 -pt None -u 0.034184780147531485 > ./result_8chains/node154_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_2 -p 549 -st topic154_4_1 -pt None -u 0.016054852116959423 > ./result_8chains/node154_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_2 -p 795 -st topic154_5_1 -pt None -u 0.013097402594309665 > ./result_8chains/node154_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_2 -p 900 -st topic154_6_1 -pt None -u 0.03559963921212677 > ./result_8chains/node154_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_2 -p 985 -st topic154_7_1 -pt None -u 0.00642255442209456 > ./result_8chains/node154_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_0 -p 119 -st none -pt topic154_0_0 -u 0.028809503728359165 > ./result_8chains/node154_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_0 -p 157 -st none -pt topic154_1_0 -u 0.00029370885651613943 > ./result_8chains/node154_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_0 -p 409 -st none -pt topic154_2_0 -u 0.031456251953628556 > ./result_8chains/node154_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_0 -p 548 -st none -pt topic154_3_0 -u 0.01976770524139798 > ./result_8chains/node154_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_0 -p 549 -st none -pt topic154_4_0 -u 0.03817365885012061 > ./result_8chains/node154_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_0 -p 795 -st none -pt topic154_5_0 -u 0.00020285269276940077 > ./result_8chains/node154_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_0 -p 900 -st none -pt topic154_6_0 -u 0.010539252520011325 > ./result_8chains/node154_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_0 -p 985 -st none -pt topic154_7_0 -u 0.019330062162873512 > ./result_8chains/node154_7_0.txt &
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
    "./result_8chains/node154_0_0.txt 90"
    "./result_8chains/node154_0_2.txt 90"
    "./result_8chains/node154_1_0.txt 89"
    "./result_8chains/node154_1_2.txt 89"
    "./result_8chains/node154_2_0.txt 88"
    "./result_8chains/node154_2_2.txt 88"
    "./result_8chains/node154_3_0.txt 87"
    "./result_8chains/node154_3_2.txt 87"
    "./result_8chains/node154_4_0.txt 86"
    "./result_8chains/node154_4_2.txt 86"
    "./result_8chains/node154_5_0.txt 85"
    "./result_8chains/node154_5_2.txt 85"
    "./result_8chains/node154_6_0.txt 84"
    "./result_8chains/node154_6_2.txt 84"
    "./result_8chains/node154_7_0.txt 83"
    "./result_8chains/node154_7_2.txt 83"
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
