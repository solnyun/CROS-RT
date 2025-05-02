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
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_2 -p 186 -st topic109_0_1 -pt None -u 0.003176005802661197 > ./result_8chains/node109_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_2 -p 240 -st topic109_1_1 -pt None -u 0.012359373105629512 > ./result_8chains/node109_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_2 -p 244 -st topic109_2_1 -pt None -u 0.006009463456582265 > ./result_8chains/node109_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_2 -p 296 -st topic109_3_1 -pt None -u 0.025925212783887208 > ./result_8chains/node109_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_2 -p 651 -st topic109_4_1 -pt None -u 0.03030501514643094 > ./result_8chains/node109_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_2 -p 729 -st topic109_5_1 -pt None -u 0.030258033256386152 > ./result_8chains/node109_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_6_2 -p 944 -st topic109_6_1 -pt None -u 0.0350910565631814 > ./result_8chains/node109_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_7_2 -p 983 -st topic109_7_1 -pt None -u 0.0243417017701068 > ./result_8chains/node109_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_0 -p 186 -st none -pt topic109_0_0 -u 0.0011554227721357058 > ./result_8chains/node109_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_0 -p 240 -st none -pt topic109_1_0 -u 0.08909480599632175 > ./result_8chains/node109_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_0 -p 244 -st none -pt topic109_2_0 -u 0.041014007860937673 > ./result_8chains/node109_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_0 -p 296 -st none -pt topic109_3_0 -u 0.010726621517011203 > ./result_8chains/node109_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_0 -p 651 -st none -pt topic109_4_0 -u 0.0270249805792937 > ./result_8chains/node109_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_0 -p 729 -st none -pt topic109_5_0 -u 0.00040646576051261984 > ./result_8chains/node109_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_6_0 -p 944 -st none -pt topic109_6_0 -u 0.02144908355596767 > ./result_8chains/node109_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_7_0 -p 983 -st none -pt topic109_7_0 -u 0.0800295967830203 > ./result_8chains/node109_7_0.txt &
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
    "./result_8chains/node109_0_0.txt 90"
    "./result_8chains/node109_0_2.txt 90"
    "./result_8chains/node109_1_0.txt 89"
    "./result_8chains/node109_1_2.txt 89"
    "./result_8chains/node109_2_0.txt 88"
    "./result_8chains/node109_2_2.txt 88"
    "./result_8chains/node109_3_0.txt 87"
    "./result_8chains/node109_3_2.txt 87"
    "./result_8chains/node109_4_0.txt 86"
    "./result_8chains/node109_4_2.txt 86"
    "./result_8chains/node109_5_0.txt 85"
    "./result_8chains/node109_5_2.txt 85"
    "./result_8chains/node109_6_0.txt 84"
    "./result_8chains/node109_6_2.txt 84"
    "./result_8chains/node109_7_0.txt 83"
    "./result_8chains/node109_7_2.txt 83"
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
