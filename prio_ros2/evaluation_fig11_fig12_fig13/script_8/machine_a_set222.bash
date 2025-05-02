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
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_2 -p 111 -st topic222_0_1 -pt None -u 0.02301552847915117 > ./result_8chains/node222_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_2 -p 195 -st topic222_1_1 -pt None -u 0.019678116570553794 > ./result_8chains/node222_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_2 -p 283 -st topic222_2_1 -pt None -u 0.010182324544593335 > ./result_8chains/node222_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_2 -p 547 -st topic222_3_1 -pt None -u 0.07928807643412011 > ./result_8chains/node222_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_2 -p 652 -st topic222_4_1 -pt None -u 0.008876136455167744 > ./result_8chains/node222_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_2 -p 805 -st topic222_5_1 -pt None -u 0.07287615402327831 > ./result_8chains/node222_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_6_2 -p 890 -st topic222_6_1 -pt None -u 0.0008178753687570622 > ./result_8chains/node222_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_7_2 -p 965 -st topic222_7_1 -pt None -u 0.017352855113087602 > ./result_8chains/node222_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_0 -p 111 -st none -pt topic222_0_0 -u 0.0203470982993319 > ./result_8chains/node222_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_0 -p 195 -st none -pt topic222_1_0 -u 0.010242179921826855 > ./result_8chains/node222_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_0 -p 283 -st none -pt topic222_2_0 -u 0.02485106616127808 > ./result_8chains/node222_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_0 -p 547 -st none -pt topic222_3_0 -u 0.003231309416977135 > ./result_8chains/node222_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_0 -p 652 -st none -pt topic222_4_0 -u 0.023414284337982594 > ./result_8chains/node222_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_0 -p 805 -st none -pt topic222_5_0 -u 0.008887033965866736 > ./result_8chains/node222_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_6_0 -p 890 -st none -pt topic222_6_0 -u 0.007615137780209363 > ./result_8chains/node222_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_7_0 -p 965 -st none -pt topic222_7_0 -u 0.02341545673286901 > ./result_8chains/node222_7_0.txt &
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
    "./result_8chains/node222_0_0.txt 90"
    "./result_8chains/node222_0_2.txt 90"
    "./result_8chains/node222_1_0.txt 89"
    "./result_8chains/node222_1_2.txt 89"
    "./result_8chains/node222_2_0.txt 88"
    "./result_8chains/node222_2_2.txt 88"
    "./result_8chains/node222_3_0.txt 87"
    "./result_8chains/node222_3_2.txt 87"
    "./result_8chains/node222_4_0.txt 86"
    "./result_8chains/node222_4_2.txt 86"
    "./result_8chains/node222_5_0.txt 85"
    "./result_8chains/node222_5_2.txt 85"
    "./result_8chains/node222_6_0.txt 84"
    "./result_8chains/node222_6_2.txt 84"
    "./result_8chains/node222_7_0.txt 83"
    "./result_8chains/node222_7_2.txt 83"
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
