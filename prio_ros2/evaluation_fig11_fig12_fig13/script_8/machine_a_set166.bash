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
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_2 -p 14 -st topic166_0_1 -pt None -u 0.023999809398993155 > ./result_8chains/node166_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_2 -p 184 -st topic166_1_1 -pt None -u 0.024371506791629582 > ./result_8chains/node166_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_2 -p 307 -st topic166_2_1 -pt None -u 0.00813071377122554 > ./result_8chains/node166_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_2 -p 454 -st topic166_3_1 -pt None -u 0.0006980479014703223 > ./result_8chains/node166_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_2 -p 460 -st topic166_4_1 -pt None -u 0.011394881608112278 > ./result_8chains/node166_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_2 -p 609 -st topic166_5_1 -pt None -u 0.061120612209057984 > ./result_8chains/node166_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_6_2 -p 879 -st topic166_6_1 -pt None -u 0.00757982838558631 > ./result_8chains/node166_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_7_2 -p 931 -st topic166_7_1 -pt None -u 0.016971159417728834 > ./result_8chains/node166_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_0 -p 14 -st none -pt topic166_0_0 -u 0.006087225735070589 > ./result_8chains/node166_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_0 -p 184 -st none -pt topic166_1_0 -u 0.00658521849520699 > ./result_8chains/node166_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_0 -p 307 -st none -pt topic166_2_0 -u 0.0013832621376111964 > ./result_8chains/node166_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_0 -p 454 -st none -pt topic166_3_0 -u 0.04830515684935155 > ./result_8chains/node166_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_0 -p 460 -st none -pt topic166_4_0 -u 0.0029788139253317247 > ./result_8chains/node166_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_0 -p 609 -st none -pt topic166_5_0 -u 0.018075970428585664 > ./result_8chains/node166_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_6_0 -p 879 -st none -pt topic166_6_0 -u 0.011487457761507947 > ./result_8chains/node166_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_7_0 -p 931 -st none -pt topic166_7_0 -u 0.06870153896594369 > ./result_8chains/node166_7_0.txt &
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
    "./result_8chains/node166_0_0.txt 90"
    "./result_8chains/node166_0_2.txt 90"
    "./result_8chains/node166_1_0.txt 89"
    "./result_8chains/node166_1_2.txt 89"
    "./result_8chains/node166_2_0.txt 88"
    "./result_8chains/node166_2_2.txt 88"
    "./result_8chains/node166_3_0.txt 87"
    "./result_8chains/node166_3_2.txt 87"
    "./result_8chains/node166_4_0.txt 86"
    "./result_8chains/node166_4_2.txt 86"
    "./result_8chains/node166_5_0.txt 85"
    "./result_8chains/node166_5_2.txt 85"
    "./result_8chains/node166_6_0.txt 84"
    "./result_8chains/node166_6_2.txt 84"
    "./result_8chains/node166_7_0.txt 83"
    "./result_8chains/node166_7_2.txt 83"
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
