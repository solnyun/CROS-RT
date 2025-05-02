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
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_2 -p 179 -st topic193_0_1 -pt None -u 0.007802077498833104 > ./result_6chains/node193_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_2 -p 229 -st topic193_1_1 -pt None -u 0.0466445839778889 > ./result_6chains/node193_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_2 -p 307 -st topic193_2_1 -pt None -u 0.026056101473214383 > ./result_6chains/node193_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_2 -p 475 -st topic193_3_1 -pt None -u 0.014944506639040123 > ./result_6chains/node193_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_2 -p 743 -st topic193_4_1 -pt None -u 0.0008859206730431751 > ./result_6chains/node193_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_2 -p 956 -st topic193_5_1 -pt None -u 0.026054213618811346 > ./result_6chains/node193_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_0 -p 179 -st none -pt topic193_0_0 -u 0.04005622103980694 > ./result_6chains/node193_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_0 -p 229 -st none -pt topic193_1_0 -u 0.023709442644306467 > ./result_6chains/node193_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_0 -p 307 -st none -pt topic193_2_0 -u 0.04043699962136907 > ./result_6chains/node193_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_0 -p 475 -st none -pt topic193_3_0 -u 0.02538847619168963 > ./result_6chains/node193_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_0 -p 743 -st none -pt topic193_4_0 -u 0.032782633823911306 > ./result_6chains/node193_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_0 -p 956 -st none -pt topic193_5_0 -u 0.004282800055736211 > ./result_6chains/node193_5_0.txt &
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
    "./result_6chains/node193_0_0.txt 90"
    "./result_6chains/node193_0_2.txt 90"
    "./result_6chains/node193_1_0.txt 89"
    "./result_6chains/node193_1_2.txt 89"
    "./result_6chains/node193_2_0.txt 88"
    "./result_6chains/node193_2_2.txt 88"
    "./result_6chains/node193_3_0.txt 87"
    "./result_6chains/node193_3_2.txt 87"
    "./result_6chains/node193_4_0.txt 86"
    "./result_6chains/node193_4_2.txt 86"
    "./result_6chains/node193_5_0.txt 85"
    "./result_6chains/node193_5_2.txt 85"
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
