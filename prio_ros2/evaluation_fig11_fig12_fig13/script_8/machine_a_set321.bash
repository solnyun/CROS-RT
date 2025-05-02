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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_2 -p 500 -st topic321_0_1 -pt None -u 0.007220433427092943 > ./result_8chains/node321_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_2 -p 617 -st topic321_1_1 -pt None -u 0.008313388888752604 > ./result_8chains/node321_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_2 -p 704 -st topic321_2_1 -pt None -u 0.022581240165716 > ./result_8chains/node321_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_2 -p 722 -st topic321_3_1 -pt None -u 0.008249010705623172 > ./result_8chains/node321_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_2 -p 782 -st topic321_4_1 -pt None -u 0.02383805401251657 > ./result_8chains/node321_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_2 -p 895 -st topic321_5_1 -pt None -u 0.002177349115566496 > ./result_8chains/node321_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_6_2 -p 987 -st topic321_6_1 -pt None -u 0.0808162159591716 > ./result_8chains/node321_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_7_2 -p 992 -st topic321_7_1 -pt None -u 0.00493011649292409 > ./result_8chains/node321_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_0 -p 500 -st none -pt topic321_0_0 -u 0.035880899692497525 > ./result_8chains/node321_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_0 -p 617 -st none -pt topic321_1_0 -u 0.018344521558642912 > ./result_8chains/node321_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_0 -p 704 -st none -pt topic321_2_0 -u 0.006722859403667625 > ./result_8chains/node321_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_0 -p 722 -st none -pt topic321_3_0 -u 0.013595229932962971 > ./result_8chains/node321_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_0 -p 782 -st none -pt topic321_4_0 -u 0.005539230994981409 > ./result_8chains/node321_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_0 -p 895 -st none -pt topic321_5_0 -u 0.0045147744758326225 > ./result_8chains/node321_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_6_0 -p 987 -st none -pt topic321_6_0 -u 0.009403033124110755 > ./result_8chains/node321_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_7_0 -p 992 -st none -pt topic321_7_0 -u 0.01795842717701969 > ./result_8chains/node321_7_0.txt &
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
    "./result_8chains/node321_0_0.txt 90"
    "./result_8chains/node321_0_2.txt 90"
    "./result_8chains/node321_1_0.txt 89"
    "./result_8chains/node321_1_2.txt 89"
    "./result_8chains/node321_2_0.txt 88"
    "./result_8chains/node321_2_2.txt 88"
    "./result_8chains/node321_3_0.txt 87"
    "./result_8chains/node321_3_2.txt 87"
    "./result_8chains/node321_4_0.txt 86"
    "./result_8chains/node321_4_2.txt 86"
    "./result_8chains/node321_5_0.txt 85"
    "./result_8chains/node321_5_2.txt 85"
    "./result_8chains/node321_6_0.txt 84"
    "./result_8chains/node321_6_2.txt 84"
    "./result_8chains/node321_7_0.txt 83"
    "./result_8chains/node321_7_2.txt 83"
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
