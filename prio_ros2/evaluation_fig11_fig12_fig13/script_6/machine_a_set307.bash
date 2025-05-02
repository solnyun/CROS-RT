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
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_2 -p 352 -st topic307_0_1 -pt None -u 0.007775310907776334 > ./result_6chains/node307_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_2 -p 389 -st topic307_1_1 -pt None -u 0.0009671522075223038 > ./result_6chains/node307_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_2 -p 397 -st topic307_2_1 -pt None -u 0.022054403887337093 > ./result_6chains/node307_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_2 -p 866 -st topic307_3_1 -pt None -u 0.011441211571501686 > ./result_6chains/node307_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_2 -p 895 -st topic307_4_1 -pt None -u 0.13530350174114147 > ./result_6chains/node307_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_2 -p 917 -st topic307_5_1 -pt None -u 0.019011443879520407 > ./result_6chains/node307_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_0 -p 352 -st none -pt topic307_0_0 -u 0.03819369606559331 > ./result_6chains/node307_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_0 -p 389 -st none -pt topic307_1_0 -u 0.01653635490169658 > ./result_6chains/node307_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_0 -p 397 -st none -pt topic307_2_0 -u 0.0014974217876054796 > ./result_6chains/node307_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_0 -p 866 -st none -pt topic307_3_0 -u 0.003973473036879227 > ./result_6chains/node307_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_0 -p 895 -st none -pt topic307_4_0 -u 0.014038507978024195 > ./result_6chains/node307_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_0 -p 917 -st none -pt topic307_5_0 -u 0.01428941014526769 > ./result_6chains/node307_5_0.txt &
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
    "./result_6chains/node307_0_0.txt 90"
    "./result_6chains/node307_0_2.txt 90"
    "./result_6chains/node307_1_0.txt 89"
    "./result_6chains/node307_1_2.txt 89"
    "./result_6chains/node307_2_0.txt 88"
    "./result_6chains/node307_2_2.txt 88"
    "./result_6chains/node307_3_0.txt 87"
    "./result_6chains/node307_3_2.txt 87"
    "./result_6chains/node307_4_0.txt 86"
    "./result_6chains/node307_4_2.txt 86"
    "./result_6chains/node307_5_0.txt 85"
    "./result_6chains/node307_5_2.txt 85"
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
