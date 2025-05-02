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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_2 -p 89 -st topic225_0_1 -pt None -u 0.005955633762329771 > ./result_8chains/node225_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_2 -p 147 -st topic225_1_1 -pt None -u 0.0712908750889607 > ./result_8chains/node225_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_2 -p 235 -st topic225_2_1 -pt None -u 0.016636480874936133 > ./result_8chains/node225_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_2 -p 567 -st topic225_3_1 -pt None -u 0.008701904437178554 > ./result_8chains/node225_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_2 -p 635 -st topic225_4_1 -pt None -u 0.0023047305347628777 > ./result_8chains/node225_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_2 -p 663 -st topic225_5_1 -pt None -u 0.028923742999240803 > ./result_8chains/node225_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_2 -p 837 -st topic225_6_1 -pt None -u 0.011708695889336002 > ./result_8chains/node225_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_2 -p 844 -st topic225_7_1 -pt None -u 0.005139161885232163 > ./result_8chains/node225_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_0 -p 89 -st none -pt topic225_0_0 -u 0.00944635131816085 > ./result_8chains/node225_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_0 -p 147 -st none -pt topic225_1_0 -u 0.016945648363880128 > ./result_8chains/node225_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_0 -p 235 -st none -pt topic225_2_0 -u 0.01819351263279173 > ./result_8chains/node225_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_0 -p 567 -st none -pt topic225_3_0 -u 0.02371644017404978 > ./result_8chains/node225_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_0 -p 635 -st none -pt topic225_4_0 -u 0.05515221938609313 > ./result_8chains/node225_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_0 -p 663 -st none -pt topic225_5_0 -u 0.017087831286298594 > ./result_8chains/node225_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_0 -p 837 -st none -pt topic225_6_0 -u 0.008314642494847688 > ./result_8chains/node225_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_0 -p 844 -st none -pt topic225_7_0 -u 0.008490748612244026 > ./result_8chains/node225_7_0.txt &
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
    "./result_8chains/node225_0_0.txt 90"
    "./result_8chains/node225_0_2.txt 90"
    "./result_8chains/node225_1_0.txt 89"
    "./result_8chains/node225_1_2.txt 89"
    "./result_8chains/node225_2_0.txt 88"
    "./result_8chains/node225_2_2.txt 88"
    "./result_8chains/node225_3_0.txt 87"
    "./result_8chains/node225_3_2.txt 87"
    "./result_8chains/node225_4_0.txt 86"
    "./result_8chains/node225_4_2.txt 86"
    "./result_8chains/node225_5_0.txt 85"
    "./result_8chains/node225_5_2.txt 85"
    "./result_8chains/node225_6_0.txt 84"
    "./result_8chains/node225_6_2.txt 84"
    "./result_8chains/node225_7_0.txt 83"
    "./result_8chains/node225_7_2.txt 83"
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
