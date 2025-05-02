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
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_2 -p 60 -st topic297_0_1 -pt None -u 0.0057938511633411904 > ./result_8chains/node297_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_2 -p 166 -st topic297_1_1 -pt None -u 0.010221857226972442 > ./result_8chains/node297_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_2 -p 297 -st topic297_2_1 -pt None -u 0.036029629977519295 > ./result_8chains/node297_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_2 -p 431 -st topic297_3_1 -pt None -u 0.019875713748437468 > ./result_8chains/node297_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_2 -p 454 -st topic297_4_1 -pt None -u 0.03569793229011714 > ./result_8chains/node297_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_2 -p 582 -st topic297_5_1 -pt None -u 0.0042048976579887945 > ./result_8chains/node297_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_2 -p 619 -st topic297_6_1 -pt None -u 0.00837891044877178 > ./result_8chains/node297_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_2 -p 731 -st topic297_7_1 -pt None -u 0.02259975736770442 > ./result_8chains/node297_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_0_0 -p 60 -st none -pt topic297_0_0 -u 0.0015099248166708379 > ./result_8chains/node297_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_1_0 -p 166 -st none -pt topic297_1_0 -u 0.008232621993551903 > ./result_8chains/node297_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_2_0 -p 297 -st none -pt topic297_2_0 -u 0.06775932224949482 > ./result_8chains/node297_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_3_0 -p 431 -st none -pt topic297_3_0 -u 0.036376628465162264 > ./result_8chains/node297_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_4_0 -p 454 -st none -pt topic297_4_0 -u 0.006451599584711698 > ./result_8chains/node297_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_5_0 -p 582 -st none -pt topic297_5_0 -u 0.030814947253159586 > ./result_8chains/node297_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node297_6_0 -p 619 -st none -pt topic297_6_0 -u 0.009387790659305117 > ./result_8chains/node297_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node297_7_0 -p 731 -st none -pt topic297_7_0 -u 0.012692673025185088 > ./result_8chains/node297_7_0.txt &
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
    "./result_8chains/node297_0_0.txt 90"
    "./result_8chains/node297_0_2.txt 90"
    "./result_8chains/node297_1_0.txt 89"
    "./result_8chains/node297_1_2.txt 89"
    "./result_8chains/node297_2_0.txt 88"
    "./result_8chains/node297_2_2.txt 88"
    "./result_8chains/node297_3_0.txt 87"
    "./result_8chains/node297_3_2.txt 87"
    "./result_8chains/node297_4_0.txt 86"
    "./result_8chains/node297_4_2.txt 86"
    "./result_8chains/node297_5_0.txt 85"
    "./result_8chains/node297_5_2.txt 85"
    "./result_8chains/node297_6_0.txt 84"
    "./result_8chains/node297_6_2.txt 84"
    "./result_8chains/node297_7_0.txt 83"
    "./result_8chains/node297_7_2.txt 83"
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
