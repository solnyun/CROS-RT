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
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_2 -p 117 -st topic127_0_1 -pt None -u 0.03573347102936825 > ./result_8chains/node127_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_2 -p 122 -st topic127_1_1 -pt None -u 0.09385645833056816 > ./result_8chains/node127_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_2 -p 287 -st topic127_2_1 -pt None -u 0.002251576279757278 > ./result_8chains/node127_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_2 -p 531 -st topic127_3_1 -pt None -u 0.01231231128432464 > ./result_8chains/node127_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_2 -p 583 -st topic127_4_1 -pt None -u 0.015758535507522126 > ./result_8chains/node127_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_2 -p 795 -st topic127_5_1 -pt None -u 0.02382737338201453 > ./result_8chains/node127_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_6_2 -p 906 -st topic127_6_1 -pt None -u 0.001078631502356965 > ./result_8chains/node127_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_7_2 -p 907 -st topic127_7_1 -pt None -u 0.012403897671342281 > ./result_8chains/node127_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_0 -p 117 -st none -pt topic127_0_0 -u 0.009243745931653446 > ./result_8chains/node127_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_0 -p 122 -st none -pt topic127_1_0 -u 0.07340542449048243 > ./result_8chains/node127_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_0 -p 287 -st none -pt topic127_2_0 -u 0.00404062339839506 > ./result_8chains/node127_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_0 -p 531 -st none -pt topic127_3_0 -u 0.03420176937983968 > ./result_8chains/node127_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_0 -p 583 -st none -pt topic127_4_0 -u 0.000873174897219331 > ./result_8chains/node127_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_0 -p 795 -st none -pt topic127_5_0 -u 0.0018955146206247053 > ./result_8chains/node127_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_6_0 -p 906 -st none -pt topic127_6_0 -u 0.025646392576004318 > ./result_8chains/node127_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_7_0 -p 907 -st none -pt topic127_7_0 -u 0.013577543381002026 > ./result_8chains/node127_7_0.txt &
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
    "./result_8chains/node127_0_0.txt 90"
    "./result_8chains/node127_0_2.txt 90"
    "./result_8chains/node127_1_0.txt 89"
    "./result_8chains/node127_1_2.txt 89"
    "./result_8chains/node127_2_0.txt 88"
    "./result_8chains/node127_2_2.txt 88"
    "./result_8chains/node127_3_0.txt 87"
    "./result_8chains/node127_3_2.txt 87"
    "./result_8chains/node127_4_0.txt 86"
    "./result_8chains/node127_4_2.txt 86"
    "./result_8chains/node127_5_0.txt 85"
    "./result_8chains/node127_5_2.txt 85"
    "./result_8chains/node127_6_0.txt 84"
    "./result_8chains/node127_6_2.txt 84"
    "./result_8chains/node127_7_0.txt 83"
    "./result_8chains/node127_7_2.txt 83"
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
