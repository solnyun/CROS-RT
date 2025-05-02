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
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_2 -p 112 -st topic364_0_1 -pt None -u 0.024644902001288216 > ./result_8chains/node364_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_2 -p 130 -st topic364_1_1 -pt None -u 0.014792412119405463 > ./result_8chains/node364_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_2 -p 189 -st topic364_2_1 -pt None -u 0.003970254286527919 > ./result_8chains/node364_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_2 -p 490 -st topic364_3_1 -pt None -u 0.009583831599607517 > ./result_8chains/node364_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_2 -p 611 -st topic364_4_1 -pt None -u 0.0034762894785977105 > ./result_8chains/node364_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_2 -p 797 -st topic364_5_1 -pt None -u 0.009316273669169844 > ./result_8chains/node364_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_2 -p 920 -st topic364_6_1 -pt None -u 0.00040389545324817644 > ./result_8chains/node364_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_2 -p 938 -st topic364_7_1 -pt None -u 0.025258695100970823 > ./result_8chains/node364_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_0_0 -p 112 -st none -pt topic364_0_0 -u 0.015992174389264258 > ./result_8chains/node364_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_1_0 -p 130 -st none -pt topic364_1_0 -u 0.0005128487112900926 > ./result_8chains/node364_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_2_0 -p 189 -st none -pt topic364_2_0 -u 0.0029808876375002624 > ./result_8chains/node364_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_3_0 -p 490 -st none -pt topic364_3_0 -u 0.0556368355774835 > ./result_8chains/node364_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_4_0 -p 611 -st none -pt topic364_4_0 -u 0.008762045715676348 > ./result_8chains/node364_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_5_0 -p 797 -st none -pt topic364_5_0 -u 0.04003125900499016 > ./result_8chains/node364_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node364_6_0 -p 920 -st none -pt topic364_6_0 -u 0.02472235358768954 > ./result_8chains/node364_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node364_7_0 -p 938 -st none -pt topic364_7_0 -u 0.08916769279975828 > ./result_8chains/node364_7_0.txt &
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
    "./result_8chains/node364_0_0.txt 90"
    "./result_8chains/node364_0_2.txt 90"
    "./result_8chains/node364_1_0.txt 89"
    "./result_8chains/node364_1_2.txt 89"
    "./result_8chains/node364_2_0.txt 88"
    "./result_8chains/node364_2_2.txt 88"
    "./result_8chains/node364_3_0.txt 87"
    "./result_8chains/node364_3_2.txt 87"
    "./result_8chains/node364_4_0.txt 86"
    "./result_8chains/node364_4_2.txt 86"
    "./result_8chains/node364_5_0.txt 85"
    "./result_8chains/node364_5_2.txt 85"
    "./result_8chains/node364_6_0.txt 84"
    "./result_8chains/node364_6_2.txt 84"
    "./result_8chains/node364_7_0.txt 83"
    "./result_8chains/node364_7_2.txt 83"
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
