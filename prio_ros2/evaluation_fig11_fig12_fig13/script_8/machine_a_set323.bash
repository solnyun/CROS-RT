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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_2 -p 160 -st topic323_0_1 -pt None -u 0.017411595862942497 > ./result_8chains/node323_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_2 -p 161 -st topic323_1_1 -pt None -u 0.08118882837971564 > ./result_8chains/node323_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_2 -p 270 -st topic323_2_1 -pt None -u 0.028282989893357313 > ./result_8chains/node323_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_2 -p 288 -st topic323_3_1 -pt None -u 0.004020239373212442 > ./result_8chains/node323_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_2 -p 649 -st topic323_4_1 -pt None -u 0.020325330088390575 > ./result_8chains/node323_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_2 -p 728 -st topic323_5_1 -pt None -u 0.03562211942870712 > ./result_8chains/node323_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_2 -p 827 -st topic323_6_1 -pt None -u 0.007361219415611589 > ./result_8chains/node323_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_2 -p 988 -st topic323_7_1 -pt None -u 0.02442763844469606 > ./result_8chains/node323_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_0 -p 160 -st none -pt topic323_0_0 -u 0.0008818052057368853 > ./result_8chains/node323_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_0 -p 161 -st none -pt topic323_1_0 -u 0.031132064684798344 > ./result_8chains/node323_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_0 -p 270 -st none -pt topic323_2_0 -u 0.0029240980021895124 > ./result_8chains/node323_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_0 -p 288 -st none -pt topic323_3_0 -u 0.0005678104101325965 > ./result_8chains/node323_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_0 -p 649 -st none -pt topic323_4_0 -u 0.005811424318115543 > ./result_8chains/node323_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_0 -p 728 -st none -pt topic323_5_0 -u 0.04245587112840349 > ./result_8chains/node323_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_0 -p 827 -st none -pt topic323_6_0 -u 0.019843656350069752 > ./result_8chains/node323_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_0 -p 988 -st none -pt topic323_7_0 -u 0.021613814315898587 > ./result_8chains/node323_7_0.txt &
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
    "./result_8chains/node323_0_0.txt 90"
    "./result_8chains/node323_0_2.txt 90"
    "./result_8chains/node323_1_0.txt 89"
    "./result_8chains/node323_1_2.txt 89"
    "./result_8chains/node323_2_0.txt 88"
    "./result_8chains/node323_2_2.txt 88"
    "./result_8chains/node323_3_0.txt 87"
    "./result_8chains/node323_3_2.txt 87"
    "./result_8chains/node323_4_0.txt 86"
    "./result_8chains/node323_4_2.txt 86"
    "./result_8chains/node323_5_0.txt 85"
    "./result_8chains/node323_5_2.txt 85"
    "./result_8chains/node323_6_0.txt 84"
    "./result_8chains/node323_6_2.txt 84"
    "./result_8chains/node323_7_0.txt 83"
    "./result_8chains/node323_7_2.txt 83"
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
