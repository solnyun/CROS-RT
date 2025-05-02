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
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_2 -p 52 -st topic54_0_1 -pt None -u 0.049651920365888114 > ./result_8chains/node54_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_2 -p 465 -st topic54_1_1 -pt None -u 0.013205691569589395 > ./result_8chains/node54_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_2 -p 660 -st topic54_2_1 -pt None -u 0.0012003002973022814 > ./result_8chains/node54_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_2 -p 661 -st topic54_3_1 -pt None -u 0.030369778923579893 > ./result_8chains/node54_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_2 -p 775 -st topic54_4_1 -pt None -u 0.020800390710654176 > ./result_8chains/node54_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_2 -p 819 -st topic54_5_1 -pt None -u 0.023676077707716292 > ./result_8chains/node54_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_2 -p 875 -st topic54_6_1 -pt None -u 0.03552528359389318 > ./result_8chains/node54_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_2 -p 950 -st topic54_7_1 -pt None -u 0.0030741329680924988 > ./result_8chains/node54_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_0 -p 52 -st none -pt topic54_0_0 -u 0.009670944417041527 > ./result_8chains/node54_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_0 -p 465 -st none -pt topic54_1_0 -u 0.00730464257387875 > ./result_8chains/node54_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_0 -p 660 -st none -pt topic54_2_0 -u 0.008310710193474624 > ./result_8chains/node54_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_0 -p 661 -st none -pt topic54_3_0 -u 0.031725791826694105 > ./result_8chains/node54_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_0 -p 775 -st none -pt topic54_4_0 -u 0.056751563016159745 > ./result_8chains/node54_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_0 -p 819 -st none -pt topic54_5_0 -u 0.010049962442211902 > ./result_8chains/node54_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_0 -p 875 -st none -pt topic54_6_0 -u 0.02403359511079703 > ./result_8chains/node54_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_0 -p 950 -st none -pt topic54_7_0 -u 0.025009294145360204 > ./result_8chains/node54_7_0.txt &
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
    "./result_8chains/node54_0_0.txt 90"
    "./result_8chains/node54_0_2.txt 90"
    "./result_8chains/node54_1_0.txt 89"
    "./result_8chains/node54_1_2.txt 89"
    "./result_8chains/node54_2_0.txt 88"
    "./result_8chains/node54_2_2.txt 88"
    "./result_8chains/node54_3_0.txt 87"
    "./result_8chains/node54_3_2.txt 87"
    "./result_8chains/node54_4_0.txt 86"
    "./result_8chains/node54_4_2.txt 86"
    "./result_8chains/node54_5_0.txt 85"
    "./result_8chains/node54_5_2.txt 85"
    "./result_8chains/node54_6_0.txt 84"
    "./result_8chains/node54_6_2.txt 84"
    "./result_8chains/node54_7_0.txt 83"
    "./result_8chains/node54_7_2.txt 83"
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
