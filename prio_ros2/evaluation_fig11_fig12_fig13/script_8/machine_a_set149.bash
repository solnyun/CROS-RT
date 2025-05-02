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
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_2 -p 29 -st topic149_0_1 -pt None -u 0.020894893718811647 > ./result_8chains/node149_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_2 -p 63 -st topic149_1_1 -pt None -u 0.010972357939857735 > ./result_8chains/node149_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_2 -p 64 -st topic149_2_1 -pt None -u 0.00648046352155579 > ./result_8chains/node149_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_2 -p 139 -st topic149_3_1 -pt None -u 0.024215906066851256 > ./result_8chains/node149_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_2 -p 165 -st topic149_4_1 -pt None -u 0.020644401783202843 > ./result_8chains/node149_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_2 -p 273 -st topic149_5_1 -pt None -u 0.006607492241134216 > ./result_8chains/node149_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_6_2 -p 361 -st topic149_6_1 -pt None -u 0.026318418542710283 > ./result_8chains/node149_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_7_2 -p 894 -st topic149_7_1 -pt None -u 0.021142936466111636 > ./result_8chains/node149_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_0 -p 29 -st none -pt topic149_0_0 -u 0.003575626148417166 > ./result_8chains/node149_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_0 -p 63 -st none -pt topic149_1_0 -u 0.01480682724692678 > ./result_8chains/node149_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_0 -p 64 -st none -pt topic149_2_0 -u 0.025718708745280372 > ./result_8chains/node149_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_0 -p 139 -st none -pt topic149_3_0 -u 0.03693449759297346 > ./result_8chains/node149_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_0 -p 165 -st none -pt topic149_4_0 -u 0.0018020234626873188 > ./result_8chains/node149_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_0 -p 273 -st none -pt topic149_5_0 -u 0.006592260164534791 > ./result_8chains/node149_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_6_0 -p 361 -st none -pt topic149_6_0 -u 0.021167755625087048 > ./result_8chains/node149_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_7_0 -p 894 -st none -pt topic149_7_0 -u 0.010350166331914684 > ./result_8chains/node149_7_0.txt &
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
    "./result_8chains/node149_0_0.txt 90"
    "./result_8chains/node149_0_2.txt 90"
    "./result_8chains/node149_1_0.txt 89"
    "./result_8chains/node149_1_2.txt 89"
    "./result_8chains/node149_2_0.txt 88"
    "./result_8chains/node149_2_2.txt 88"
    "./result_8chains/node149_3_0.txt 87"
    "./result_8chains/node149_3_2.txt 87"
    "./result_8chains/node149_4_0.txt 86"
    "./result_8chains/node149_4_2.txt 86"
    "./result_8chains/node149_5_0.txt 85"
    "./result_8chains/node149_5_2.txt 85"
    "./result_8chains/node149_6_0.txt 84"
    "./result_8chains/node149_6_2.txt 84"
    "./result_8chains/node149_7_0.txt 83"
    "./result_8chains/node149_7_2.txt 83"
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
