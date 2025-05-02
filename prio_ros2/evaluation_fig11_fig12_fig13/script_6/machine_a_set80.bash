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
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_2 -p 236 -st topic80_0_1 -pt None -u 0.09413518408829252 > ./result_6chains/node80_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_2 -p 535 -st topic80_1_1 -pt None -u 0.0019751589838122863 > ./result_6chains/node80_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_2 -p 628 -st topic80_2_1 -pt None -u 0.029613834857599913 > ./result_6chains/node80_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_2 -p 819 -st topic80_3_1 -pt None -u 0.006802098916345284 > ./result_6chains/node80_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_2 -p 892 -st topic80_4_1 -pt None -u 0.020480197610819297 > ./result_6chains/node80_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_2 -p 899 -st topic80_5_1 -pt None -u 0.013661577252049306 > ./result_6chains/node80_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_0 -p 236 -st none -pt topic80_0_0 -u 0.003174426537258357 > ./result_6chains/node80_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_0 -p 535 -st none -pt topic80_1_0 -u 0.029346351693142703 > ./result_6chains/node80_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_0 -p 628 -st none -pt topic80_2_0 -u 0.006350732078156229 > ./result_6chains/node80_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_0 -p 819 -st none -pt topic80_3_0 -u 0.05287151048701873 > ./result_6chains/node80_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_0 -p 892 -st none -pt topic80_4_0 -u 0.006602908429252152 > ./result_6chains/node80_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_0 -p 899 -st none -pt topic80_5_0 -u 0.0357081251140313 > ./result_6chains/node80_5_0.txt &
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
    "./result_6chains/node80_0_0.txt 90"
    "./result_6chains/node80_0_2.txt 90"
    "./result_6chains/node80_1_0.txt 89"
    "./result_6chains/node80_1_2.txt 89"
    "./result_6chains/node80_2_0.txt 88"
    "./result_6chains/node80_2_2.txt 88"
    "./result_6chains/node80_3_0.txt 87"
    "./result_6chains/node80_3_2.txt 87"
    "./result_6chains/node80_4_0.txt 86"
    "./result_6chains/node80_4_2.txt 86"
    "./result_6chains/node80_5_0.txt 85"
    "./result_6chains/node80_5_2.txt 85"
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
