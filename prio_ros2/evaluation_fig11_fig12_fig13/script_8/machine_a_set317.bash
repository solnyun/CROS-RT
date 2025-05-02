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
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_2 -p 36 -st topic317_0_1 -pt None -u 0.00014159374985805995 > ./result_8chains/node317_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_2 -p 82 -st topic317_1_1 -pt None -u 0.006168598152595406 > ./result_8chains/node317_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_2 -p 214 -st topic317_2_1 -pt None -u 0.04223508068072762 > ./result_8chains/node317_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_2 -p 232 -st topic317_3_1 -pt None -u 0.03673978351955129 > ./result_8chains/node317_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_2 -p 359 -st topic317_4_1 -pt None -u 0.010051022022030037 > ./result_8chains/node317_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_2 -p 601 -st topic317_5_1 -pt None -u 0.02661743455502104 > ./result_8chains/node317_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_2 -p 813 -st topic317_6_1 -pt None -u 0.003498538450417671 > ./result_8chains/node317_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_2 -p 985 -st topic317_7_1 -pt None -u 0.005441921710676955 > ./result_8chains/node317_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_0 -p 36 -st none -pt topic317_0_0 -u 0.0027332067578549335 > ./result_8chains/node317_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_0 -p 82 -st none -pt topic317_1_0 -u 0.013255553537935949 > ./result_8chains/node317_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_0 -p 214 -st none -pt topic317_2_0 -u 0.050319088066216766 > ./result_8chains/node317_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_0 -p 232 -st none -pt topic317_3_0 -u 0.04363685868997347 > ./result_8chains/node317_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_0 -p 359 -st none -pt topic317_4_0 -u 0.016796380256481558 > ./result_8chains/node317_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_0 -p 601 -st none -pt topic317_5_0 -u 0.03164035372384916 > ./result_8chains/node317_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_6_0 -p 813 -st none -pt topic317_6_0 -u 0.005822183585855137 > ./result_8chains/node317_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_7_0 -p 985 -st none -pt topic317_7_0 -u 0.023227763479023184 > ./result_8chains/node317_7_0.txt &
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
    "./result_8chains/node317_0_0.txt 90"
    "./result_8chains/node317_0_2.txt 90"
    "./result_8chains/node317_1_0.txt 89"
    "./result_8chains/node317_1_2.txt 89"
    "./result_8chains/node317_2_0.txt 88"
    "./result_8chains/node317_2_2.txt 88"
    "./result_8chains/node317_3_0.txt 87"
    "./result_8chains/node317_3_2.txt 87"
    "./result_8chains/node317_4_0.txt 86"
    "./result_8chains/node317_4_2.txt 86"
    "./result_8chains/node317_5_0.txt 85"
    "./result_8chains/node317_5_2.txt 85"
    "./result_8chains/node317_6_0.txt 84"
    "./result_8chains/node317_6_2.txt 84"
    "./result_8chains/node317_7_0.txt 83"
    "./result_8chains/node317_7_2.txt 83"
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
