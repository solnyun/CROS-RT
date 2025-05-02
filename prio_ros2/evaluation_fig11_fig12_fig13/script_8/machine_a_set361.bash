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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_2 -p 23 -st topic361_0_1 -pt None -u 0.013206690277841437 > ./result_8chains/node361_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_2 -p 26 -st topic361_1_1 -pt None -u 0.00714861045378079 > ./result_8chains/node361_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_2 -p 36 -st topic361_2_1 -pt None -u 0.05412418189277701 > ./result_8chains/node361_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_2 -p 299 -st topic361_3_1 -pt None -u 0.011225918455371436 > ./result_8chains/node361_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_2 -p 515 -st topic361_4_1 -pt None -u 0.030549516775917634 > ./result_8chains/node361_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_2 -p 770 -st topic361_5_1 -pt None -u 0.02980623630567529 > ./result_8chains/node361_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_2 -p 907 -st topic361_6_1 -pt None -u 0.013371959160287994 > ./result_8chains/node361_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_2 -p 959 -st topic361_7_1 -pt None -u 0.0048105991232543525 > ./result_8chains/node361_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_0 -p 23 -st none -pt topic361_0_0 -u 0.009026789671476632 > ./result_8chains/node361_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_0 -p 26 -st none -pt topic361_1_0 -u 0.02979955415578328 > ./result_8chains/node361_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_0 -p 36 -st none -pt topic361_2_0 -u 0.03447779010562224 > ./result_8chains/node361_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_0 -p 299 -st none -pt topic361_3_0 -u 0.0002385505370071095 > ./result_8chains/node361_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_0 -p 515 -st none -pt topic361_4_0 -u 0.029580488030595042 > ./result_8chains/node361_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_0 -p 770 -st none -pt topic361_5_0 -u 0.04643281754296118 > ./result_8chains/node361_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_6_0 -p 907 -st none -pt topic361_6_0 -u 0.012687469469118348 > ./result_8chains/node361_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node361_7_0 -p 959 -st none -pt topic361_7_0 -u 0.00860291990952151 > ./result_8chains/node361_7_0.txt &
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
    "./result_8chains/node361_0_0.txt 90"
    "./result_8chains/node361_0_2.txt 90"
    "./result_8chains/node361_1_0.txt 89"
    "./result_8chains/node361_1_2.txt 89"
    "./result_8chains/node361_2_0.txt 88"
    "./result_8chains/node361_2_2.txt 88"
    "./result_8chains/node361_3_0.txt 87"
    "./result_8chains/node361_3_2.txt 87"
    "./result_8chains/node361_4_0.txt 86"
    "./result_8chains/node361_4_2.txt 86"
    "./result_8chains/node361_5_0.txt 85"
    "./result_8chains/node361_5_2.txt 85"
    "./result_8chains/node361_6_0.txt 84"
    "./result_8chains/node361_6_2.txt 84"
    "./result_8chains/node361_7_0.txt 83"
    "./result_8chains/node361_7_2.txt 83"
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
