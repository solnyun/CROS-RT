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
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_2 -p 116 -st topic16_0_1 -pt None -u 0.049412904726403084 > ./result_8chains/node16_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_2 -p 209 -st topic16_1_1 -pt None -u 0.014297369934080484 > ./result_8chains/node16_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_2 -p 337 -st topic16_2_1 -pt None -u 0.002152028694154151 > ./result_8chains/node16_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_2 -p 390 -st topic16_3_1 -pt None -u 0.013118792654345207 > ./result_8chains/node16_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_2 -p 428 -st topic16_4_1 -pt None -u 0.017677343355515046 > ./result_8chains/node16_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_2 -p 596 -st topic16_5_1 -pt None -u 0.0016076027763967798 > ./result_8chains/node16_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_6_2 -p 611 -st topic16_6_1 -pt None -u 0.011760104868424156 > ./result_8chains/node16_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_7_2 -p 731 -st topic16_7_1 -pt None -u 0.014584228259051266 > ./result_8chains/node16_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_0 -p 116 -st none -pt topic16_0_0 -u 0.024788976281998554 > ./result_8chains/node16_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_0 -p 209 -st none -pt topic16_1_0 -u 0.01452939814841886 > ./result_8chains/node16_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_0 -p 337 -st none -pt topic16_2_0 -u 0.045928595449748144 > ./result_8chains/node16_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_0 -p 390 -st none -pt topic16_3_0 -u 0.050946059479138384 > ./result_8chains/node16_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_0 -p 428 -st none -pt topic16_4_0 -u 0.00226805173515382 > ./result_8chains/node16_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_0 -p 596 -st none -pt topic16_5_0 -u 0.0053431912188249275 > ./result_8chains/node16_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_6_0 -p 611 -st none -pt topic16_6_0 -u 0.022965617474946104 > ./result_8chains/node16_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_7_0 -p 731 -st none -pt topic16_7_0 -u 0.007011850306096839 > ./result_8chains/node16_7_0.txt &
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
    "./result_8chains/node16_0_0.txt 90"
    "./result_8chains/node16_0_2.txt 90"
    "./result_8chains/node16_1_0.txt 89"
    "./result_8chains/node16_1_2.txt 89"
    "./result_8chains/node16_2_0.txt 88"
    "./result_8chains/node16_2_2.txt 88"
    "./result_8chains/node16_3_0.txt 87"
    "./result_8chains/node16_3_2.txt 87"
    "./result_8chains/node16_4_0.txt 86"
    "./result_8chains/node16_4_2.txt 86"
    "./result_8chains/node16_5_0.txt 85"
    "./result_8chains/node16_5_2.txt 85"
    "./result_8chains/node16_6_0.txt 84"
    "./result_8chains/node16_6_2.txt 84"
    "./result_8chains/node16_7_0.txt 83"
    "./result_8chains/node16_7_2.txt 83"
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
