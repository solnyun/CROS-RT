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
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_2 -p 113 -st topic70_0_1 -pt None -u 0.02786049109012345 > ./result_8chains/node70_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_2 -p 229 -st topic70_1_1 -pt None -u 0.0037529771969714854 > ./result_8chains/node70_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_2 -p 292 -st topic70_2_1 -pt None -u 0.03589120595906897 > ./result_8chains/node70_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_2 -p 487 -st topic70_3_1 -pt None -u 0.04531134718250113 > ./result_8chains/node70_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_2 -p 542 -st topic70_4_1 -pt None -u 0.0037279425865844873 > ./result_8chains/node70_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_2 -p 596 -st topic70_5_1 -pt None -u 0.008030902396320636 > ./result_8chains/node70_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_6_2 -p 602 -st topic70_6_1 -pt None -u 0.010847967678413277 > ./result_8chains/node70_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_7_2 -p 603 -st topic70_7_1 -pt None -u 0.020637204090006758 > ./result_8chains/node70_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_0 -p 113 -st none -pt topic70_0_0 -u 0.020889279763996682 > ./result_8chains/node70_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_0 -p 229 -st none -pt topic70_1_0 -u 0.0026530499152519482 > ./result_8chains/node70_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_0 -p 292 -st none -pt topic70_2_0 -u 0.02165195313060153 > ./result_8chains/node70_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_0 -p 487 -st none -pt topic70_3_0 -u 0.001941529035802414 > ./result_8chains/node70_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_0 -p 542 -st none -pt topic70_4_0 -u 0.040487880261932035 > ./result_8chains/node70_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_0 -p 596 -st none -pt topic70_5_0 -u 0.019179678638978404 > ./result_8chains/node70_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_6_0 -p 602 -st none -pt topic70_6_0 -u 0.013339640064087492 > ./result_8chains/node70_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_7_0 -p 603 -st none -pt topic70_7_0 -u 0.008452009725978014 > ./result_8chains/node70_7_0.txt &
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
    "./result_8chains/node70_0_0.txt 90"
    "./result_8chains/node70_0_2.txt 90"
    "./result_8chains/node70_1_0.txt 89"
    "./result_8chains/node70_1_2.txt 89"
    "./result_8chains/node70_2_0.txt 88"
    "./result_8chains/node70_2_2.txt 88"
    "./result_8chains/node70_3_0.txt 87"
    "./result_8chains/node70_3_2.txt 87"
    "./result_8chains/node70_4_0.txt 86"
    "./result_8chains/node70_4_2.txt 86"
    "./result_8chains/node70_5_0.txt 85"
    "./result_8chains/node70_5_2.txt 85"
    "./result_8chains/node70_6_0.txt 84"
    "./result_8chains/node70_6_2.txt 84"
    "./result_8chains/node70_7_0.txt 83"
    "./result_8chains/node70_7_2.txt 83"
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
