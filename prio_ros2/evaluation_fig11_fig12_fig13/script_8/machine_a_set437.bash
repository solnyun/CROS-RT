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
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_2 -p 103 -st topic437_0_1 -pt None -u 0.013227680634509131 > ./result_8chains/node437_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_2 -p 125 -st topic437_1_1 -pt None -u 0.014079910562974252 > ./result_8chains/node437_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_2 -p 144 -st topic437_2_1 -pt None -u 0.007853559382611008 > ./result_8chains/node437_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_2 -p 204 -st topic437_3_1 -pt None -u 0.040854838001677274 > ./result_8chains/node437_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_2 -p 285 -st topic437_4_1 -pt None -u 0.013515521600514668 > ./result_8chains/node437_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_2 -p 363 -st topic437_5_1 -pt None -u 0.02490560250857507 > ./result_8chains/node437_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_2 -p 632 -st topic437_6_1 -pt None -u 0.04605806696764385 > ./result_8chains/node437_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_2 -p 964 -st topic437_7_1 -pt None -u 0.0538646529285982 > ./result_8chains/node437_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_0 -p 103 -st none -pt topic437_0_0 -u 0.01431942127719582 > ./result_8chains/node437_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_0 -p 125 -st none -pt topic437_1_0 -u 0.04775920790391974 > ./result_8chains/node437_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_0 -p 144 -st none -pt topic437_2_0 -u 0.06299698611547955 > ./result_8chains/node437_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_0 -p 204 -st none -pt topic437_3_0 -u 0.0057290233850738614 > ./result_8chains/node437_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_0 -p 285 -st none -pt topic437_4_0 -u 0.011235822481399316 > ./result_8chains/node437_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_0 -p 363 -st none -pt topic437_5_0 -u 0.009949950381355321 > ./result_8chains/node437_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_0 -p 632 -st none -pt topic437_6_0 -u 0.01146879035992382 > ./result_8chains/node437_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_0 -p 964 -st none -pt topic437_7_0 -u 0.03144842105702632 > ./result_8chains/node437_7_0.txt &
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
    "./result_8chains/node437_0_0.txt 90"
    "./result_8chains/node437_0_2.txt 90"
    "./result_8chains/node437_1_0.txt 89"
    "./result_8chains/node437_1_2.txt 89"
    "./result_8chains/node437_2_0.txt 88"
    "./result_8chains/node437_2_2.txt 88"
    "./result_8chains/node437_3_0.txt 87"
    "./result_8chains/node437_3_2.txt 87"
    "./result_8chains/node437_4_0.txt 86"
    "./result_8chains/node437_4_2.txt 86"
    "./result_8chains/node437_5_0.txt 85"
    "./result_8chains/node437_5_2.txt 85"
    "./result_8chains/node437_6_0.txt 84"
    "./result_8chains/node437_6_2.txt 84"
    "./result_8chains/node437_7_0.txt 83"
    "./result_8chains/node437_7_2.txt 83"
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
