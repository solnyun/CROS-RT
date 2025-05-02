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
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_2 -p 94 -st topic450_0_1 -pt None -u 0.019408542269242546 > ./result_8chains/node450_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_2 -p 216 -st topic450_1_1 -pt None -u 0.0031208227424942003 > ./result_8chains/node450_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_2 -p 221 -st topic450_2_1 -pt None -u 0.01768285704040884 > ./result_8chains/node450_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_2 -p 489 -st topic450_3_1 -pt None -u 0.0003187095344258095 > ./result_8chains/node450_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_2 -p 507 -st topic450_4_1 -pt None -u 0.013242485772723744 > ./result_8chains/node450_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_2 -p 596 -st topic450_5_1 -pt None -u 0.0024394772403107112 > ./result_8chains/node450_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_6_2 -p 665 -st topic450_6_1 -pt None -u 0.0016982843570806094 > ./result_8chains/node450_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_7_2 -p 834 -st topic450_7_1 -pt None -u 0.04110929223169223 > ./result_8chains/node450_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_0 -p 94 -st none -pt topic450_0_0 -u 0.10524218102940053 > ./result_8chains/node450_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_0 -p 216 -st none -pt topic450_1_0 -u 0.0389075049468402 > ./result_8chains/node450_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_0 -p 221 -st none -pt topic450_2_0 -u 0.018536206626547147 > ./result_8chains/node450_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_0 -p 489 -st none -pt topic450_3_0 -u 0.015237099821968303 > ./result_8chains/node450_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_0 -p 507 -st none -pt topic450_4_0 -u 0.008304506254694782 > ./result_8chains/node450_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_0 -p 596 -st none -pt topic450_5_0 -u 0.01583738745168045 > ./result_8chains/node450_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_6_0 -p 665 -st none -pt topic450_6_0 -u 0.05532259732158494 > ./result_8chains/node450_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_7_0 -p 834 -st none -pt topic450_7_0 -u 0.012459514153982727 > ./result_8chains/node450_7_0.txt &
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
    "./result_8chains/node450_0_0.txt 90"
    "./result_8chains/node450_0_2.txt 90"
    "./result_8chains/node450_1_0.txt 89"
    "./result_8chains/node450_1_2.txt 89"
    "./result_8chains/node450_2_0.txt 88"
    "./result_8chains/node450_2_2.txt 88"
    "./result_8chains/node450_3_0.txt 87"
    "./result_8chains/node450_3_2.txt 87"
    "./result_8chains/node450_4_0.txt 86"
    "./result_8chains/node450_4_2.txt 86"
    "./result_8chains/node450_5_0.txt 85"
    "./result_8chains/node450_5_2.txt 85"
    "./result_8chains/node450_6_0.txt 84"
    "./result_8chains/node450_6_2.txt 84"
    "./result_8chains/node450_7_0.txt 83"
    "./result_8chains/node450_7_2.txt 83"
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
