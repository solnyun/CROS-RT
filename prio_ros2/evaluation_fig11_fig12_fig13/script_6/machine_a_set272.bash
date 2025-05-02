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
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_2 -p 80 -st topic272_0_1 -pt None -u 0.028419157154934593 > ./result_6chains/node272_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_2 -p 393 -st topic272_1_1 -pt None -u 0.005282173419618008 > ./result_6chains/node272_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_2 -p 410 -st topic272_2_1 -pt None -u 0.0349517651897602 > ./result_6chains/node272_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_2 -p 620 -st topic272_3_1 -pt None -u 0.018534829079004618 > ./result_6chains/node272_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_2 -p 839 -st topic272_4_1 -pt None -u 0.007281989377637663 > ./result_6chains/node272_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_2 -p 921 -st topic272_5_1 -pt None -u 0.017374091106265126 > ./result_6chains/node272_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_0 -p 80 -st none -pt topic272_0_0 -u 0.016948718694813847 > ./result_6chains/node272_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_0 -p 393 -st none -pt topic272_1_0 -u 0.0928869244948538 > ./result_6chains/node272_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_0 -p 410 -st none -pt topic272_2_0 -u 0.00890639515875885 > ./result_6chains/node272_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_0 -p 620 -st none -pt topic272_3_0 -u 0.04680396341029164 > ./result_6chains/node272_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_0 -p 839 -st none -pt topic272_4_0 -u 0.01316333161522757 > ./result_6chains/node272_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_0 -p 921 -st none -pt topic272_5_0 -u 0.0005074234759601254 > ./result_6chains/node272_5_0.txt &
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
    "./result_6chains/node272_0_0.txt 90"
    "./result_6chains/node272_0_2.txt 90"
    "./result_6chains/node272_1_0.txt 89"
    "./result_6chains/node272_1_2.txt 89"
    "./result_6chains/node272_2_0.txt 88"
    "./result_6chains/node272_2_2.txt 88"
    "./result_6chains/node272_3_0.txt 87"
    "./result_6chains/node272_3_2.txt 87"
    "./result_6chains/node272_4_0.txt 86"
    "./result_6chains/node272_4_2.txt 86"
    "./result_6chains/node272_5_0.txt 85"
    "./result_6chains/node272_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
