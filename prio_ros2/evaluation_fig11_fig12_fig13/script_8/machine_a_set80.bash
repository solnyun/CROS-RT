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
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_2 -p 121 -st topic80_0_1 -pt None -u 0.03011932924446792 > ./result_8chains/node80_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_2 -p 206 -st topic80_1_1 -pt None -u 0.017447644011179986 > ./result_8chains/node80_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_2 -p 352 -st topic80_2_1 -pt None -u 0.0012838127486430873 > ./result_8chains/node80_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_2 -p 384 -st topic80_3_1 -pt None -u 0.026070541381751244 > ./result_8chains/node80_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_2 -p 385 -st topic80_4_1 -pt None -u 0.026504332720602847 > ./result_8chains/node80_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_2 -p 411 -st topic80_5_1 -pt None -u 0.001918255646283909 > ./result_8chains/node80_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_6_2 -p 503 -st topic80_6_1 -pt None -u 0.028914724630982512 > ./result_8chains/node80_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_7_2 -p 556 -st topic80_7_1 -pt None -u 0.008278931494059904 > ./result_8chains/node80_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_0 -p 121 -st none -pt topic80_0_0 -u 0.03340128448223789 > ./result_8chains/node80_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_0 -p 206 -st none -pt topic80_1_0 -u 0.03213345141735979 > ./result_8chains/node80_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_0 -p 352 -st none -pt topic80_2_0 -u 0.014827089020915396 > ./result_8chains/node80_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_0 -p 384 -st none -pt topic80_3_0 -u 0.017858923999931164 > ./result_8chains/node80_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_0 -p 385 -st none -pt topic80_4_0 -u 0.03444932179746704 > ./result_8chains/node80_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_0 -p 411 -st none -pt topic80_5_0 -u 0.008574679300114602 > ./result_8chains/node80_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_6_0 -p 503 -st none -pt topic80_6_0 -u 0.007993577316076028 > ./result_8chains/node80_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_7_0 -p 556 -st none -pt topic80_7_0 -u 0.009530823308793755 > ./result_8chains/node80_7_0.txt &
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
    "./result_8chains/node80_0_0.txt 90"
    "./result_8chains/node80_0_2.txt 90"
    "./result_8chains/node80_1_0.txt 89"
    "./result_8chains/node80_1_2.txt 89"
    "./result_8chains/node80_2_0.txt 88"
    "./result_8chains/node80_2_2.txt 88"
    "./result_8chains/node80_3_0.txt 87"
    "./result_8chains/node80_3_2.txt 87"
    "./result_8chains/node80_4_0.txt 86"
    "./result_8chains/node80_4_2.txt 86"
    "./result_8chains/node80_5_0.txt 85"
    "./result_8chains/node80_5_2.txt 85"
    "./result_8chains/node80_6_0.txt 84"
    "./result_8chains/node80_6_2.txt 84"
    "./result_8chains/node80_7_0.txt 83"
    "./result_8chains/node80_7_2.txt 83"
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
