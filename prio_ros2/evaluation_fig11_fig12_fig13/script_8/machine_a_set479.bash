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
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_2 -p 224 -st topic479_0_1 -pt None -u 0.00012679750155764058 > ./result_8chains/node479_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_2 -p 290 -st topic479_1_1 -pt None -u 0.0035606130455287377 > ./result_8chains/node479_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_2 -p 456 -st topic479_2_1 -pt None -u 0.0037908193526405287 > ./result_8chains/node479_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_2 -p 578 -st topic479_3_1 -pt None -u 0.020777241083117126 > ./result_8chains/node479_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_2 -p 658 -st topic479_4_1 -pt None -u 0.02000741374430437 > ./result_8chains/node479_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_2 -p 675 -st topic479_5_1 -pt None -u 0.0032341353206001844 > ./result_8chains/node479_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_2 -p 830 -st topic479_6_1 -pt None -u 0.009841339407160032 > ./result_8chains/node479_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_2 -p 890 -st topic479_7_1 -pt None -u 0.005046925764539575 > ./result_8chains/node479_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_0 -p 224 -st none -pt topic479_0_0 -u 0.0446536522543039 > ./result_8chains/node479_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_0 -p 290 -st none -pt topic479_1_0 -u 0.00442223734560554 > ./result_8chains/node479_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_0 -p 456 -st none -pt topic479_2_0 -u 0.0912741693779171 > ./result_8chains/node479_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_0 -p 578 -st none -pt topic479_3_0 -u 0.0010070121518970798 > ./result_8chains/node479_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_0 -p 658 -st none -pt topic479_4_0 -u 0.010928327761548118 > ./result_8chains/node479_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_0 -p 675 -st none -pt topic479_5_0 -u 0.004963925972446159 > ./result_8chains/node479_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_0 -p 830 -st none -pt topic479_6_0 -u 0.0054013521177107005 > ./result_8chains/node479_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_0 -p 890 -st none -pt topic479_7_0 -u 0.0034536366519169887 > ./result_8chains/node479_7_0.txt &
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
    "./result_8chains/node479_0_0.txt 90"
    "./result_8chains/node479_0_2.txt 90"
    "./result_8chains/node479_1_0.txt 89"
    "./result_8chains/node479_1_2.txt 89"
    "./result_8chains/node479_2_0.txt 88"
    "./result_8chains/node479_2_2.txt 88"
    "./result_8chains/node479_3_0.txt 87"
    "./result_8chains/node479_3_2.txt 87"
    "./result_8chains/node479_4_0.txt 86"
    "./result_8chains/node479_4_2.txt 86"
    "./result_8chains/node479_5_0.txt 85"
    "./result_8chains/node479_5_2.txt 85"
    "./result_8chains/node479_6_0.txt 84"
    "./result_8chains/node479_6_2.txt 84"
    "./result_8chains/node479_7_0.txt 83"
    "./result_8chains/node479_7_2.txt 83"
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
