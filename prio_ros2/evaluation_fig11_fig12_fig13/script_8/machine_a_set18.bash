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
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_2 -p 68 -st topic18_0_1 -pt None -u 0.0014975941737599974 > ./result_8chains/node18_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_2 -p 160 -st topic18_1_1 -pt None -u 0.0074850812418499335 > ./result_8chains/node18_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_2 -p 171 -st topic18_2_1 -pt None -u 0.02209226998585684 > ./result_8chains/node18_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_2 -p 648 -st topic18_3_1 -pt None -u 0.014074912525821714 > ./result_8chains/node18_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_2 -p 702 -st topic18_4_1 -pt None -u 0.0001368737813458032 > ./result_8chains/node18_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_2 -p 836 -st topic18_5_1 -pt None -u 0.011933690857781523 > ./result_8chains/node18_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_6_2 -p 892 -st topic18_6_1 -pt None -u 0.03335722356016912 > ./result_8chains/node18_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_7_2 -p 978 -st topic18_7_1 -pt None -u 0.010452567312627087 > ./result_8chains/node18_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_0 -p 68 -st none -pt topic18_0_0 -u 0.032882814072378974 > ./result_8chains/node18_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_0 -p 160 -st none -pt topic18_1_0 -u 0.004719113957069643 > ./result_8chains/node18_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_0 -p 171 -st none -pt topic18_2_0 -u 0.06678338609141105 > ./result_8chains/node18_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_0 -p 648 -st none -pt topic18_3_0 -u 0.011416558157922252 > ./result_8chains/node18_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_0 -p 702 -st none -pt topic18_4_0 -u 0.0002498989432694887 > ./result_8chains/node18_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_0 -p 836 -st none -pt topic18_5_0 -u 0.1263936051942828 > ./result_8chains/node18_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_6_0 -p 892 -st none -pt topic18_6_0 -u 0.00723894630244884 > ./result_8chains/node18_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_7_0 -p 978 -st none -pt topic18_7_0 -u 0.010275222291064777 > ./result_8chains/node18_7_0.txt &
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
    "./result_8chains/node18_0_0.txt 90"
    "./result_8chains/node18_0_2.txt 90"
    "./result_8chains/node18_1_0.txt 89"
    "./result_8chains/node18_1_2.txt 89"
    "./result_8chains/node18_2_0.txt 88"
    "./result_8chains/node18_2_2.txt 88"
    "./result_8chains/node18_3_0.txt 87"
    "./result_8chains/node18_3_2.txt 87"
    "./result_8chains/node18_4_0.txt 86"
    "./result_8chains/node18_4_2.txt 86"
    "./result_8chains/node18_5_0.txt 85"
    "./result_8chains/node18_5_2.txt 85"
    "./result_8chains/node18_6_0.txt 84"
    "./result_8chains/node18_6_2.txt 84"
    "./result_8chains/node18_7_0.txt 83"
    "./result_8chains/node18_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
