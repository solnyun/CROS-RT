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
ros2 run evaluation_3_randomdag uunifast_node -n node283_0_2 -p 93 -st topic283_0_1 -pt None -u 0.03918734974193516 > ./result_8chains/node283_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_1_2 -p 305 -st topic283_1_1 -pt None -u 0.01628881663154602 > ./result_8chains/node283_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_2_2 -p 421 -st topic283_2_1 -pt None -u 0.030061403733149916 > ./result_8chains/node283_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_3_2 -p 488 -st topic283_3_1 -pt None -u 0.007112434165321813 > ./result_8chains/node283_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_4_2 -p 576 -st topic283_4_1 -pt None -u 0.002585421518343789 > ./result_8chains/node283_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_5_2 -p 580 -st topic283_5_1 -pt None -u 0.016019418059470103 > ./result_8chains/node283_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_6_2 -p 792 -st topic283_6_1 -pt None -u 0.0052025501836772264 > ./result_8chains/node283_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_7_2 -p 832 -st topic283_7_1 -pt None -u 0.025336237628836678 > ./result_8chains/node283_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_0_0 -p 93 -st none -pt topic283_0_0 -u 0.03151799706832825 > ./result_8chains/node283_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_1_0 -p 305 -st none -pt topic283_1_0 -u 0.00024982841102771935 > ./result_8chains/node283_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_2_0 -p 421 -st none -pt topic283_2_0 -u 0.017232143525956922 > ./result_8chains/node283_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_3_0 -p 488 -st none -pt topic283_3_0 -u 0.0002504419813066372 > ./result_8chains/node283_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_4_0 -p 576 -st none -pt topic283_4_0 -u 0.038235935343561206 > ./result_8chains/node283_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_5_0 -p 580 -st none -pt topic283_5_0 -u 0.013852224327224105 > ./result_8chains/node283_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_6_0 -p 792 -st none -pt topic283_6_0 -u 0.021730927112725076 > ./result_8chains/node283_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node283_7_0 -p 832 -st none -pt topic283_7_0 -u 0.03210835185158405 > ./result_8chains/node283_7_0.txt &
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
    "./result_8chains/node283_0_0.txt 90"
    "./result_8chains/node283_0_2.txt 90"
    "./result_8chains/node283_1_0.txt 89"
    "./result_8chains/node283_1_2.txt 89"
    "./result_8chains/node283_2_0.txt 88"
    "./result_8chains/node283_2_2.txt 88"
    "./result_8chains/node283_3_0.txt 87"
    "./result_8chains/node283_3_2.txt 87"
    "./result_8chains/node283_4_0.txt 86"
    "./result_8chains/node283_4_2.txt 86"
    "./result_8chains/node283_5_0.txt 85"
    "./result_8chains/node283_5_2.txt 85"
    "./result_8chains/node283_6_0.txt 84"
    "./result_8chains/node283_6_2.txt 84"
    "./result_8chains/node283_7_0.txt 83"
    "./result_8chains/node283_7_2.txt 83"
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
