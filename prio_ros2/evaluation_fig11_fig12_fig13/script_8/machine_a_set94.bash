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
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_2 -p 66 -st topic94_0_1 -pt None -u 0.04171134023888906 > ./result_8chains/node94_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_2 -p 96 -st topic94_1_1 -pt None -u 0.0029694431535277066 > ./result_8chains/node94_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_2 -p 216 -st topic94_2_1 -pt None -u 0.01131073112882336 > ./result_8chains/node94_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_2 -p 377 -st topic94_3_1 -pt None -u 0.008985030059997401 > ./result_8chains/node94_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_2 -p 692 -st topic94_4_1 -pt None -u 0.019492473490983014 > ./result_8chains/node94_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_2 -p 957 -st topic94_5_1 -pt None -u 0.03169443736943049 > ./result_8chains/node94_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_6_2 -p 970 -st topic94_6_1 -pt None -u 0.02665674053978307 > ./result_8chains/node94_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_7_2 -p 987 -st topic94_7_1 -pt None -u 0.04067463802819612 > ./result_8chains/node94_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_0 -p 66 -st none -pt topic94_0_0 -u 0.007770543532498675 > ./result_8chains/node94_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_0 -p 96 -st none -pt topic94_1_0 -u 0.047326755764580564 > ./result_8chains/node94_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_0 -p 216 -st none -pt topic94_2_0 -u 0.04196675957727536 > ./result_8chains/node94_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_0 -p 377 -st none -pt topic94_3_0 -u 0.02262062044713048 > ./result_8chains/node94_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_0 -p 692 -st none -pt topic94_4_0 -u 0.0017396153759550448 > ./result_8chains/node94_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_0 -p 957 -st none -pt topic94_5_0 -u 0.0029068928856695597 > ./result_8chains/node94_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_6_0 -p 970 -st none -pt topic94_6_0 -u 0.007447977457493107 > ./result_8chains/node94_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node94_7_0 -p 987 -st none -pt topic94_7_0 -u 0.0025429111613137004 > ./result_8chains/node94_7_0.txt &
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
    "./result_8chains/node94_0_0.txt 90"
    "./result_8chains/node94_0_2.txt 90"
    "./result_8chains/node94_1_0.txt 89"
    "./result_8chains/node94_1_2.txt 89"
    "./result_8chains/node94_2_0.txt 88"
    "./result_8chains/node94_2_2.txt 88"
    "./result_8chains/node94_3_0.txt 87"
    "./result_8chains/node94_3_2.txt 87"
    "./result_8chains/node94_4_0.txt 86"
    "./result_8chains/node94_4_2.txt 86"
    "./result_8chains/node94_5_0.txt 85"
    "./result_8chains/node94_5_2.txt 85"
    "./result_8chains/node94_6_0.txt 84"
    "./result_8chains/node94_6_2.txt 84"
    "./result_8chains/node94_7_0.txt 83"
    "./result_8chains/node94_7_2.txt 83"
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
