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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_2 -p 395 -st topic260_0_1 -pt None -u 0.013184769301382349 > ./result_4chains/node260_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_2 -p 633 -st topic260_1_1 -pt None -u 0.1962378521441156 > ./result_4chains/node260_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_2 -p 654 -st topic260_2_1 -pt None -u 0.007589408578779322 > ./result_4chains/node260_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_2 -p 885 -st topic260_3_1 -pt None -u 0.07904661978747003 > ./result_4chains/node260_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_0 -p 395 -st none -pt topic260_0_0 -u 0.0033361971998482343 > ./result_4chains/node260_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_0 -p 633 -st none -pt topic260_1_0 -u 0.06445880068225718 > ./result_4chains/node260_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_0 -p 654 -st none -pt topic260_2_0 -u 0.036963326227269944 > ./result_4chains/node260_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_0 -p 885 -st none -pt topic260_3_0 -u 0.02890502602130622 > ./result_4chains/node260_3_0.txt &
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
    "./result_4chains/node260_0_0.txt 90"
    "./result_4chains/node260_0_2.txt 90"
    "./result_4chains/node260_1_0.txt 89"
    "./result_4chains/node260_1_2.txt 89"
    "./result_4chains/node260_2_0.txt 88"
    "./result_4chains/node260_2_2.txt 88"
    "./result_4chains/node260_3_0.txt 87"
    "./result_4chains/node260_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
