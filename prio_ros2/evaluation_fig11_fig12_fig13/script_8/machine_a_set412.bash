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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_2 -p 53 -st topic412_0_1 -pt None -u 0.01882425783908709 > ./result_8chains/node412_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_2 -p 337 -st topic412_1_1 -pt None -u 0.01830921644566863 > ./result_8chains/node412_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_2 -p 514 -st topic412_2_1 -pt None -u 0.00945480692599654 > ./result_8chains/node412_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_2 -p 541 -st topic412_3_1 -pt None -u 0.040842279483463195 > ./result_8chains/node412_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_2 -p 737 -st topic412_4_1 -pt None -u 0.007241917261245373 > ./result_8chains/node412_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_2 -p 854 -st topic412_5_1 -pt None -u 0.005524477288318563 > ./result_8chains/node412_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_2 -p 882 -st topic412_6_1 -pt None -u 0.035328796694394544 > ./result_8chains/node412_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_2 -p 894 -st topic412_7_1 -pt None -u 0.0035755373914829157 > ./result_8chains/node412_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_0 -p 53 -st none -pt topic412_0_0 -u 0.005258924354623662 > ./result_8chains/node412_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_0 -p 337 -st none -pt topic412_1_0 -u 0.03580761110232028 > ./result_8chains/node412_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_0 -p 514 -st none -pt topic412_2_0 -u 0.011173311305588407 > ./result_8chains/node412_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_0 -p 541 -st none -pt topic412_3_0 -u 0.024553536296035516 > ./result_8chains/node412_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_0 -p 737 -st none -pt topic412_4_0 -u 0.002823997142887752 > ./result_8chains/node412_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_0 -p 854 -st none -pt topic412_5_0 -u 0.013834137174904282 > ./result_8chains/node412_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_0 -p 882 -st none -pt topic412_6_0 -u 0.029045598815794244 > ./result_8chains/node412_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_0 -p 894 -st none -pt topic412_7_0 -u 0.004117794801265444 > ./result_8chains/node412_7_0.txt &
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
    "./result_8chains/node412_0_0.txt 90"
    "./result_8chains/node412_0_2.txt 90"
    "./result_8chains/node412_1_0.txt 89"
    "./result_8chains/node412_1_2.txt 89"
    "./result_8chains/node412_2_0.txt 88"
    "./result_8chains/node412_2_2.txt 88"
    "./result_8chains/node412_3_0.txt 87"
    "./result_8chains/node412_3_2.txt 87"
    "./result_8chains/node412_4_0.txt 86"
    "./result_8chains/node412_4_2.txt 86"
    "./result_8chains/node412_5_0.txt 85"
    "./result_8chains/node412_5_2.txt 85"
    "./result_8chains/node412_6_0.txt 84"
    "./result_8chains/node412_6_2.txt 84"
    "./result_8chains/node412_7_0.txt 83"
    "./result_8chains/node412_7_2.txt 83"
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
