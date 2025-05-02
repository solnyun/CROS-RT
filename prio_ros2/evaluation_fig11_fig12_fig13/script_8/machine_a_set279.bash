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
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_2 -p 47 -st topic279_0_1 -pt None -u 0.0007230554636896147 > ./result_8chains/node279_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_2 -p 125 -st topic279_1_1 -pt None -u 0.03278096746176323 > ./result_8chains/node279_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_2 -p 171 -st topic279_2_1 -pt None -u 0.011064464009574115 > ./result_8chains/node279_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_2 -p 197 -st topic279_3_1 -pt None -u 0.02178063106700623 > ./result_8chains/node279_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_2 -p 420 -st topic279_4_1 -pt None -u 0.029912745478480413 > ./result_8chains/node279_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_2 -p 582 -st topic279_5_1 -pt None -u 0.006411962001438912 > ./result_8chains/node279_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_6_2 -p 588 -st topic279_6_1 -pt None -u 0.017201389764664027 > ./result_8chains/node279_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_7_2 -p 775 -st topic279_7_1 -pt None -u 0.016858774285783817 > ./result_8chains/node279_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_0 -p 47 -st none -pt topic279_0_0 -u 0.01643356143705965 > ./result_8chains/node279_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_0 -p 125 -st none -pt topic279_1_0 -u 0.007458124286302492 > ./result_8chains/node279_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_0 -p 171 -st none -pt topic279_2_0 -u 0.03262583058398011 > ./result_8chains/node279_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_0 -p 197 -st none -pt topic279_3_0 -u 0.035398134989430174 > ./result_8chains/node279_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_0 -p 420 -st none -pt topic279_4_0 -u 0.006388244573412527 > ./result_8chains/node279_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_0 -p 582 -st none -pt topic279_5_0 -u 0.00429470582989365 > ./result_8chains/node279_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_6_0 -p 588 -st none -pt topic279_6_0 -u 0.04872326908284989 > ./result_8chains/node279_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_7_0 -p 775 -st none -pt topic279_7_0 -u 0.0024737233197133154 > ./result_8chains/node279_7_0.txt &
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
    "./result_8chains/node279_0_0.txt 90"
    "./result_8chains/node279_0_2.txt 90"
    "./result_8chains/node279_1_0.txt 89"
    "./result_8chains/node279_1_2.txt 89"
    "./result_8chains/node279_2_0.txt 88"
    "./result_8chains/node279_2_2.txt 88"
    "./result_8chains/node279_3_0.txt 87"
    "./result_8chains/node279_3_2.txt 87"
    "./result_8chains/node279_4_0.txt 86"
    "./result_8chains/node279_4_2.txt 86"
    "./result_8chains/node279_5_0.txt 85"
    "./result_8chains/node279_5_2.txt 85"
    "./result_8chains/node279_6_0.txt 84"
    "./result_8chains/node279_6_2.txt 84"
    "./result_8chains/node279_7_0.txt 83"
    "./result_8chains/node279_7_2.txt 83"
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
