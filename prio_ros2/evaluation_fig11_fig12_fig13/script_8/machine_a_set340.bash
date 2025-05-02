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
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_2 -p 274 -st topic340_0_1 -pt None -u 0.019439764123991676 > ./result_8chains/node340_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_2 -p 295 -st topic340_1_1 -pt None -u 0.020511815991397397 > ./result_8chains/node340_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_2 -p 388 -st topic340_2_1 -pt None -u 0.014755684187425011 > ./result_8chains/node340_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_2 -p 421 -st topic340_3_1 -pt None -u 0.00669858067658502 > ./result_8chains/node340_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_2 -p 474 -st topic340_4_1 -pt None -u 0.026564127816807226 > ./result_8chains/node340_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_2 -p 498 -st topic340_5_1 -pt None -u 0.04639356085782759 > ./result_8chains/node340_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_6_2 -p 737 -st topic340_6_1 -pt None -u 0.03202676060956525 > ./result_8chains/node340_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_7_2 -p 929 -st topic340_7_1 -pt None -u 0.08094949844922411 > ./result_8chains/node340_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_0 -p 274 -st none -pt topic340_0_0 -u 0.007753220263076288 > ./result_8chains/node340_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_0 -p 295 -st none -pt topic340_1_0 -u 0.006589457328504689 > ./result_8chains/node340_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_0 -p 388 -st none -pt topic340_2_0 -u 0.0021494475332947682 > ./result_8chains/node340_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_0 -p 421 -st none -pt topic340_3_0 -u 0.01062218725588876 > ./result_8chains/node340_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_0 -p 474 -st none -pt topic340_4_0 -u 0.016994334899407604 > ./result_8chains/node340_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_0 -p 498 -st none -pt topic340_5_0 -u 0.0174960212500537 > ./result_8chains/node340_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_6_0 -p 737 -st none -pt topic340_6_0 -u 0.005812663483961894 > ./result_8chains/node340_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_7_0 -p 929 -st none -pt topic340_7_0 -u 0.03824187660545936 > ./result_8chains/node340_7_0.txt &
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
    "./result_8chains/node340_0_0.txt 90"
    "./result_8chains/node340_0_2.txt 90"
    "./result_8chains/node340_1_0.txt 89"
    "./result_8chains/node340_1_2.txt 89"
    "./result_8chains/node340_2_0.txt 88"
    "./result_8chains/node340_2_2.txt 88"
    "./result_8chains/node340_3_0.txt 87"
    "./result_8chains/node340_3_2.txt 87"
    "./result_8chains/node340_4_0.txt 86"
    "./result_8chains/node340_4_2.txt 86"
    "./result_8chains/node340_5_0.txt 85"
    "./result_8chains/node340_5_2.txt 85"
    "./result_8chains/node340_6_0.txt 84"
    "./result_8chains/node340_6_2.txt 84"
    "./result_8chains/node340_7_0.txt 83"
    "./result_8chains/node340_7_2.txt 83"
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
