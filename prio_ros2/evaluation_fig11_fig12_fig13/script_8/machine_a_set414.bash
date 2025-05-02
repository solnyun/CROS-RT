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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_2 -p 51 -st topic414_0_1 -pt None -u 0.014547284314651465 > ./result_8chains/node414_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_2 -p 184 -st topic414_1_1 -pt None -u 0.0009272934426420854 > ./result_8chains/node414_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_2 -p 201 -st topic414_2_1 -pt None -u 0.023643953843378696 > ./result_8chains/node414_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_2 -p 260 -st topic414_3_1 -pt None -u 0.017163078514001173 > ./result_8chains/node414_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_2 -p 363 -st topic414_4_1 -pt None -u 0.02320271218401651 > ./result_8chains/node414_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_2 -p 433 -st topic414_5_1 -pt None -u 0.008702791913062072 > ./result_8chains/node414_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_2 -p 575 -st topic414_6_1 -pt None -u 0.005139826578598697 > ./result_8chains/node414_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_2 -p 755 -st topic414_7_1 -pt None -u 0.03796667857702337 > ./result_8chains/node414_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_0 -p 51 -st none -pt topic414_0_0 -u 0.044176463689599155 > ./result_8chains/node414_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_0 -p 184 -st none -pt topic414_1_0 -u 0.028615028330522485 > ./result_8chains/node414_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_0 -p 201 -st none -pt topic414_2_0 -u 0.08936691503767058 > ./result_8chains/node414_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_0 -p 260 -st none -pt topic414_3_0 -u 0.02606944761875085 > ./result_8chains/node414_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_0 -p 363 -st none -pt topic414_4_0 -u 0.014676686770369485 > ./result_8chains/node414_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_0 -p 433 -st none -pt topic414_5_0 -u 0.006248800140303906 > ./result_8chains/node414_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_0 -p 575 -st none -pt topic414_6_0 -u 0.012556332178866023 > ./result_8chains/node414_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_0 -p 755 -st none -pt topic414_7_0 -u 0.04326891455231724 > ./result_8chains/node414_7_0.txt &
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
    "./result_8chains/node414_0_0.txt 90"
    "./result_8chains/node414_0_2.txt 90"
    "./result_8chains/node414_1_0.txt 89"
    "./result_8chains/node414_1_2.txt 89"
    "./result_8chains/node414_2_0.txt 88"
    "./result_8chains/node414_2_2.txt 88"
    "./result_8chains/node414_3_0.txt 87"
    "./result_8chains/node414_3_2.txt 87"
    "./result_8chains/node414_4_0.txt 86"
    "./result_8chains/node414_4_2.txt 86"
    "./result_8chains/node414_5_0.txt 85"
    "./result_8chains/node414_5_2.txt 85"
    "./result_8chains/node414_6_0.txt 84"
    "./result_8chains/node414_6_2.txt 84"
    "./result_8chains/node414_7_0.txt 83"
    "./result_8chains/node414_7_2.txt 83"
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
