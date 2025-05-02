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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_2 -p 114 -st topic38_0_1 -pt None -u 0.027314791565143326 > ./result_4chains/node38_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_2 -p 602 -st topic38_1_1 -pt None -u 0.13064822879318758 > ./result_4chains/node38_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_2 -p 711 -st topic38_2_1 -pt None -u 0.00017550310649183665 > ./result_4chains/node38_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_2 -p 740 -st topic38_3_1 -pt None -u 0.017729182579818096 > ./result_4chains/node38_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_0 -p 114 -st none -pt topic38_0_0 -u 0.014819328074909766 > ./result_4chains/node38_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_0 -p 602 -st none -pt topic38_1_0 -u 0.06017817851257301 > ./result_4chains/node38_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_0 -p 711 -st none -pt topic38_2_0 -u 0.021007655303805745 > ./result_4chains/node38_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_0 -p 740 -st none -pt topic38_3_0 -u 0.02442533628096928 > ./result_4chains/node38_3_0.txt &
sleep 10
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
    "./result_4chains/node38_0_0.txt 90"
    "./result_4chains/node38_0_2.txt 90"
    "./result_4chains/node38_1_0.txt 89"
    "./result_4chains/node38_1_2.txt 89"
    "./result_4chains/node38_2_0.txt 88"
    "./result_4chains/node38_2_2.txt 88"
    "./result_4chains/node38_3_0.txt 87"
    "./result_4chains/node38_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
