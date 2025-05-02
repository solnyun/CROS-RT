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
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_2 -p 45 -st topic343_0_1 -pt None -u 0.0023605062255773746 > ./result_8chains/node343_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_2 -p 73 -st topic343_1_1 -pt None -u 0.023792011373334476 > ./result_8chains/node343_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_2 -p 239 -st topic343_2_1 -pt None -u 0.019283632378796434 > ./result_8chains/node343_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_2 -p 392 -st topic343_3_1 -pt None -u 0.04485614086215978 > ./result_8chains/node343_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_2 -p 462 -st topic343_4_1 -pt None -u 0.0026048287741217424 > ./result_8chains/node343_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_2 -p 743 -st topic343_5_1 -pt None -u 0.026156687902914005 > ./result_8chains/node343_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_6_2 -p 802 -st topic343_6_1 -pt None -u 0.0038919153858167077 > ./result_8chains/node343_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_7_2 -p 995 -st topic343_7_1 -pt None -u 0.04972725341783922 > ./result_8chains/node343_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_0 -p 45 -st none -pt topic343_0_0 -u 0.007726141554676158 > ./result_8chains/node343_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_0 -p 73 -st none -pt topic343_1_0 -u 0.008569092049559579 > ./result_8chains/node343_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_0 -p 239 -st none -pt topic343_2_0 -u 0.008752559219815104 > ./result_8chains/node343_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_0 -p 392 -st none -pt topic343_3_0 -u 0.05369548583200212 > ./result_8chains/node343_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_0 -p 462 -st none -pt topic343_4_0 -u 0.02008039010499313 > ./result_8chains/node343_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_0 -p 743 -st none -pt topic343_5_0 -u 0.03702293157231934 > ./result_8chains/node343_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_6_0 -p 802 -st none -pt topic343_6_0 -u 0.0005744966141359997 > ./result_8chains/node343_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_7_0 -p 995 -st none -pt topic343_7_0 -u 0.019382204333120823 > ./result_8chains/node343_7_0.txt &
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
    "./result_8chains/node343_0_0.txt 90"
    "./result_8chains/node343_0_2.txt 90"
    "./result_8chains/node343_1_0.txt 89"
    "./result_8chains/node343_1_2.txt 89"
    "./result_8chains/node343_2_0.txt 88"
    "./result_8chains/node343_2_2.txt 88"
    "./result_8chains/node343_3_0.txt 87"
    "./result_8chains/node343_3_2.txt 87"
    "./result_8chains/node343_4_0.txt 86"
    "./result_8chains/node343_4_2.txt 86"
    "./result_8chains/node343_5_0.txt 85"
    "./result_8chains/node343_5_2.txt 85"
    "./result_8chains/node343_6_0.txt 84"
    "./result_8chains/node343_6_2.txt 84"
    "./result_8chains/node343_7_0.txt 83"
    "./result_8chains/node343_7_2.txt 83"
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
