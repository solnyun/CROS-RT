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
ros2 run evaluation_3_randomdag uunifast_node -n node301_0_2 -p 226 -st topic301_0_1 -pt None -u 0.030697570403715735 > ./result_8chains/node301_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_1_2 -p 277 -st topic301_1_1 -pt None -u 0.041315386697613615 > ./result_8chains/node301_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_2_2 -p 690 -st topic301_2_1 -pt None -u 0.00902187919420444 > ./result_8chains/node301_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_3_2 -p 716 -st topic301_3_1 -pt None -u 0.0033396141406078217 > ./result_8chains/node301_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_4_2 -p 723 -st topic301_4_1 -pt None -u 0.002839266984987751 > ./result_8chains/node301_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_5_2 -p 764 -st topic301_5_1 -pt None -u 0.0007813863842376506 > ./result_8chains/node301_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_6_2 -p 922 -st topic301_6_1 -pt None -u 0.008416799417470262 > ./result_8chains/node301_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_7_2 -p 970 -st topic301_7_1 -pt None -u 0.02153805261916247 > ./result_8chains/node301_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_0_0 -p 226 -st none -pt topic301_0_0 -u 0.1398125363173615 > ./result_8chains/node301_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_1_0 -p 277 -st none -pt topic301_1_0 -u 0.01643284070387213 > ./result_8chains/node301_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_2_0 -p 690 -st none -pt topic301_2_0 -u 0.057657865142975995 > ./result_8chains/node301_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_3_0 -p 716 -st none -pt topic301_3_0 -u 0.0013104177664096384 > ./result_8chains/node301_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_4_0 -p 723 -st none -pt topic301_4_0 -u 0.022225788262411866 > ./result_8chains/node301_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_5_0 -p 764 -st none -pt topic301_5_0 -u 0.0032622361898376195 > ./result_8chains/node301_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node301_6_0 -p 922 -st none -pt topic301_6_0 -u 0.013004806078603298 > ./result_8chains/node301_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node301_7_0 -p 970 -st none -pt topic301_7_0 -u 0.009803034508756747 > ./result_8chains/node301_7_0.txt &
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
    "./result_8chains/node301_0_0.txt 90"
    "./result_8chains/node301_0_2.txt 90"
    "./result_8chains/node301_1_0.txt 89"
    "./result_8chains/node301_1_2.txt 89"
    "./result_8chains/node301_2_0.txt 88"
    "./result_8chains/node301_2_2.txt 88"
    "./result_8chains/node301_3_0.txt 87"
    "./result_8chains/node301_3_2.txt 87"
    "./result_8chains/node301_4_0.txt 86"
    "./result_8chains/node301_4_2.txt 86"
    "./result_8chains/node301_5_0.txt 85"
    "./result_8chains/node301_5_2.txt 85"
    "./result_8chains/node301_6_0.txt 84"
    "./result_8chains/node301_6_2.txt 84"
    "./result_8chains/node301_7_0.txt 83"
    "./result_8chains/node301_7_2.txt 83"
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
