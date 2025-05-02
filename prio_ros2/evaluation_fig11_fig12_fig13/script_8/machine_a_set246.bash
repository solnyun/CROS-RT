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
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_2 -p 275 -st topic246_0_1 -pt None -u 0.013486730277504688 > ./result_8chains/node246_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_2 -p 372 -st topic246_1_1 -pt None -u 0.0010650235234997973 > ./result_8chains/node246_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_2 -p 597 -st topic246_2_1 -pt None -u 0.016365611984212936 > ./result_8chains/node246_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_2 -p 613 -st topic246_3_1 -pt None -u 0.0012223618652348889 > ./result_8chains/node246_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_2 -p 749 -st topic246_4_1 -pt None -u 0.0442296160786361 > ./result_8chains/node246_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_2 -p 898 -st topic246_5_1 -pt None -u 0.014639108782358384 > ./result_8chains/node246_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_6_2 -p 981 -st topic246_6_1 -pt None -u 0.02521050027129755 > ./result_8chains/node246_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_7_2 -p 991 -st topic246_7_1 -pt None -u 0.053157523383798706 > ./result_8chains/node246_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_0 -p 275 -st none -pt topic246_0_0 -u 0.009035546483614432 > ./result_8chains/node246_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_0 -p 372 -st none -pt topic246_1_0 -u 0.05625505280058407 > ./result_8chains/node246_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_0 -p 597 -st none -pt topic246_2_0 -u 0.014655339500045661 > ./result_8chains/node246_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_0 -p 613 -st none -pt topic246_3_0 -u 0.022767102976433917 > ./result_8chains/node246_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_0 -p 749 -st none -pt topic246_4_0 -u 0.029056003314425316 > ./result_8chains/node246_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_0 -p 898 -st none -pt topic246_5_0 -u 0.01686922842267921 > ./result_8chains/node246_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_6_0 -p 981 -st none -pt topic246_6_0 -u 0.00043102853310988953 > ./result_8chains/node246_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_7_0 -p 991 -st none -pt topic246_7_0 -u 0.019603037271253766 > ./result_8chains/node246_7_0.txt &
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
    "./result_8chains/node246_0_0.txt 90"
    "./result_8chains/node246_0_2.txt 90"
    "./result_8chains/node246_1_0.txt 89"
    "./result_8chains/node246_1_2.txt 89"
    "./result_8chains/node246_2_0.txt 88"
    "./result_8chains/node246_2_2.txt 88"
    "./result_8chains/node246_3_0.txt 87"
    "./result_8chains/node246_3_2.txt 87"
    "./result_8chains/node246_4_0.txt 86"
    "./result_8chains/node246_4_2.txt 86"
    "./result_8chains/node246_5_0.txt 85"
    "./result_8chains/node246_5_2.txt 85"
    "./result_8chains/node246_6_0.txt 84"
    "./result_8chains/node246_6_2.txt 84"
    "./result_8chains/node246_7_0.txt 83"
    "./result_8chains/node246_7_2.txt 83"
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
