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
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_2 -p 168 -st topic177_0_1 -pt None -u 0.010074102561094922 > ./result_6chains/node177_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_2 -p 612 -st topic177_1_1 -pt None -u 0.01383392063313199 > ./result_6chains/node177_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_2 -p 697 -st topic177_2_1 -pt None -u 0.034181099161752715 > ./result_6chains/node177_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_2 -p 754 -st topic177_3_1 -pt None -u 0.0024054250233305485 > ./result_6chains/node177_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_2 -p 828 -st topic177_4_1 -pt None -u 0.004812802158080623 > ./result_6chains/node177_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_2 -p 851 -st topic177_5_1 -pt None -u 0.07978464414190226 > ./result_6chains/node177_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_0 -p 168 -st none -pt topic177_0_0 -u 0.04309011941860125 > ./result_6chains/node177_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_0 -p 612 -st none -pt topic177_1_0 -u 0.0868218812309704 > ./result_6chains/node177_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_0 -p 697 -st none -pt topic177_2_0 -u 0.0012450956953879988 > ./result_6chains/node177_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_0 -p 754 -st none -pt topic177_3_0 -u 0.026454554439568734 > ./result_6chains/node177_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_0 -p 828 -st none -pt topic177_4_0 -u 0.07741646951243575 > ./result_6chains/node177_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_0 -p 851 -st none -pt topic177_5_0 -u 0.01179153895374592 > ./result_6chains/node177_5_0.txt &
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
    "./result_6chains/node177_0_0.txt 90"
    "./result_6chains/node177_0_2.txt 90"
    "./result_6chains/node177_1_0.txt 89"
    "./result_6chains/node177_1_2.txt 89"
    "./result_6chains/node177_2_0.txt 88"
    "./result_6chains/node177_2_2.txt 88"
    "./result_6chains/node177_3_0.txt 87"
    "./result_6chains/node177_3_2.txt 87"
    "./result_6chains/node177_4_0.txt 86"
    "./result_6chains/node177_4_2.txt 86"
    "./result_6chains/node177_5_0.txt 85"
    "./result_6chains/node177_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
