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
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_2 -p 355 -st topic4_0_1 -pt None -u 0.013348313592162708 > ./result_8chains/node4_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_2 -p 458 -st topic4_1_1 -pt None -u 0.017117931917562945 > ./result_8chains/node4_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_2 -p 460 -st topic4_2_1 -pt None -u 0.0543039312538785 > ./result_8chains/node4_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_2 -p 648 -st topic4_3_1 -pt None -u 0.006372105471693035 > ./result_8chains/node4_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_2 -p 657 -st topic4_4_1 -pt None -u 0.0033403485447627834 > ./result_8chains/node4_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_2 -p 751 -st topic4_5_1 -pt None -u 0.021611242579565967 > ./result_8chains/node4_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_6_2 -p 817 -st topic4_6_1 -pt None -u 0.024829341628196333 > ./result_8chains/node4_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_7_2 -p 916 -st topic4_7_1 -pt None -u 0.01571103605345019 > ./result_8chains/node4_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_0_0 -p 355 -st none -pt topic4_0_0 -u 0.007212669620388357 > ./result_8chains/node4_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_1_0 -p 458 -st none -pt topic4_1_0 -u 0.0038790053020311688 > ./result_8chains/node4_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_2_0 -p 460 -st none -pt topic4_2_0 -u 0.009148965961361666 > ./result_8chains/node4_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_3_0 -p 648 -st none -pt topic4_3_0 -u 0.07693634859151982 > ./result_8chains/node4_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_4_0 -p 657 -st none -pt topic4_4_0 -u 0.002220261698381798 > ./result_8chains/node4_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_5_0 -p 751 -st none -pt topic4_5_0 -u 0.03313987259444098 > ./result_8chains/node4_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node4_6_0 -p 817 -st none -pt topic4_6_0 -u 0.02111012686448252 > ./result_8chains/node4_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node4_7_0 -p 916 -st none -pt topic4_7_0 -u 0.011054183768669401 > ./result_8chains/node4_7_0.txt &
sleep 10
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
    "./result_8chains/node4_0_0.txt 90"
    "./result_8chains/node4_0_2.txt 90"
    "./result_8chains/node4_1_0.txt 89"
    "./result_8chains/node4_1_2.txt 89"
    "./result_8chains/node4_2_0.txt 88"
    "./result_8chains/node4_2_2.txt 88"
    "./result_8chains/node4_3_0.txt 87"
    "./result_8chains/node4_3_2.txt 87"
    "./result_8chains/node4_4_0.txt 86"
    "./result_8chains/node4_4_2.txt 86"
    "./result_8chains/node4_5_0.txt 85"
    "./result_8chains/node4_5_2.txt 85"
    "./result_8chains/node4_6_0.txt 84"
    "./result_8chains/node4_6_2.txt 84"
    "./result_8chains/node4_7_0.txt 83"
    "./result_8chains/node4_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
