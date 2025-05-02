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
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_2 -p 58 -st topic216_0_1 -pt None -u 0.0071310388711900985 > ./result_8chains/node216_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_2 -p 71 -st topic216_1_1 -pt None -u 0.10023020496535873 > ./result_8chains/node216_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_2 -p 133 -st topic216_2_1 -pt None -u 0.047031181300658836 > ./result_8chains/node216_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_2 -p 238 -st topic216_3_1 -pt None -u 0.029288844243624407 > ./result_8chains/node216_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_2 -p 442 -st topic216_4_1 -pt None -u 0.005558368857805848 > ./result_8chains/node216_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_2 -p 487 -st topic216_5_1 -pt None -u 0.009977790212244278 > ./result_8chains/node216_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_6_2 -p 602 -st topic216_6_1 -pt None -u 0.0005321244289209701 > ./result_8chains/node216_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_7_2 -p 605 -st topic216_7_1 -pt None -u 0.0021211583431170137 > ./result_8chains/node216_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_0 -p 58 -st none -pt topic216_0_0 -u 0.0018944879072425036 > ./result_8chains/node216_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_0 -p 71 -st none -pt topic216_1_0 -u 0.05134906501896647 > ./result_8chains/node216_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_0 -p 133 -st none -pt topic216_2_0 -u 0.002187135009504182 > ./result_8chains/node216_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_0 -p 238 -st none -pt topic216_3_0 -u 0.05132131665285458 > ./result_8chains/node216_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_0 -p 442 -st none -pt topic216_4_0 -u 0.009260398152374949 > ./result_8chains/node216_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_0 -p 487 -st none -pt topic216_5_0 -u 0.0020852048168610443 > ./result_8chains/node216_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_6_0 -p 602 -st none -pt topic216_6_0 -u 0.018422642064751298 > ./result_8chains/node216_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_7_0 -p 605 -st none -pt topic216_7_0 -u 0.03172685134957369 > ./result_8chains/node216_7_0.txt &
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
    "./result_8chains/node216_0_0.txt 90"
    "./result_8chains/node216_0_2.txt 90"
    "./result_8chains/node216_1_0.txt 89"
    "./result_8chains/node216_1_2.txt 89"
    "./result_8chains/node216_2_0.txt 88"
    "./result_8chains/node216_2_2.txt 88"
    "./result_8chains/node216_3_0.txt 87"
    "./result_8chains/node216_3_2.txt 87"
    "./result_8chains/node216_4_0.txt 86"
    "./result_8chains/node216_4_2.txt 86"
    "./result_8chains/node216_5_0.txt 85"
    "./result_8chains/node216_5_2.txt 85"
    "./result_8chains/node216_6_0.txt 84"
    "./result_8chains/node216_6_2.txt 84"
    "./result_8chains/node216_7_0.txt 83"
    "./result_8chains/node216_7_2.txt 83"
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
