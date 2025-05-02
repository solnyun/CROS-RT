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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_2 -p 65 -st topic260_0_1 -pt None -u 0.00025997531677968144 > ./result_8chains/node260_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_2 -p 168 -st topic260_1_1 -pt None -u 0.04241470058708513 > ./result_8chains/node260_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_2 -p 217 -st topic260_2_1 -pt None -u 0.025216298112931912 > ./result_8chains/node260_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_2 -p 692 -st topic260_3_1 -pt None -u 0.023882134957286416 > ./result_8chains/node260_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_2 -p 711 -st topic260_4_1 -pt None -u 0.0025991445603959495 > ./result_8chains/node260_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_2 -p 750 -st topic260_5_1 -pt None -u 0.08790563657967304 > ./result_8chains/node260_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_2 -p 761 -st topic260_6_1 -pt None -u 0.01132445650549628 > ./result_8chains/node260_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_2 -p 914 -st topic260_7_1 -pt None -u 0.0175838122069644 > ./result_8chains/node260_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_0 -p 65 -st none -pt topic260_0_0 -u 0.004228535281736223 > ./result_8chains/node260_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_0 -p 168 -st none -pt topic260_1_0 -u 0.02805329167353926 > ./result_8chains/node260_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_0 -p 217 -st none -pt topic260_2_0 -u 0.03227283143413001 > ./result_8chains/node260_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_0 -p 692 -st none -pt topic260_3_0 -u 0.01686838799967666 > ./result_8chains/node260_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_0 -p 711 -st none -pt topic260_4_0 -u 0.004357792885068323 > ./result_8chains/node260_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_0 -p 750 -st none -pt topic260_5_0 -u 0.024559298911464772 > ./result_8chains/node260_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_0 -p 761 -st none -pt topic260_6_0 -u 0.017287579605734224 > ./result_8chains/node260_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_0 -p 914 -st none -pt topic260_7_0 -u 0.014847765755995515 > ./result_8chains/node260_7_0.txt &
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
    "./result_8chains/node260_0_0.txt 90"
    "./result_8chains/node260_0_2.txt 90"
    "./result_8chains/node260_1_0.txt 89"
    "./result_8chains/node260_1_2.txt 89"
    "./result_8chains/node260_2_0.txt 88"
    "./result_8chains/node260_2_2.txt 88"
    "./result_8chains/node260_3_0.txt 87"
    "./result_8chains/node260_3_2.txt 87"
    "./result_8chains/node260_4_0.txt 86"
    "./result_8chains/node260_4_2.txt 86"
    "./result_8chains/node260_5_0.txt 85"
    "./result_8chains/node260_5_2.txt 85"
    "./result_8chains/node260_6_0.txt 84"
    "./result_8chains/node260_6_2.txt 84"
    "./result_8chains/node260_7_0.txt 83"
    "./result_8chains/node260_7_2.txt 83"
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
