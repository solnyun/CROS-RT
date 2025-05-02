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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_2 -p 123 -st topic104_0_1 -pt None -u 0.0010896973599194837 > ./result_8chains/node104_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_2 -p 365 -st topic104_1_1 -pt None -u 0.004306938337036326 > ./result_8chains/node104_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_2 -p 367 -st topic104_2_1 -pt None -u 0.0018358729017893816 > ./result_8chains/node104_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_2 -p 449 -st topic104_3_1 -pt None -u 0.009590370844409057 > ./result_8chains/node104_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_2 -p 510 -st topic104_4_1 -pt None -u 0.002033988122659258 > ./result_8chains/node104_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_2 -p 582 -st topic104_5_1 -pt None -u 0.03854890589507409 > ./result_8chains/node104_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_2 -p 583 -st topic104_6_1 -pt None -u 0.022301778978116332 > ./result_8chains/node104_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_2 -p 710 -st topic104_7_1 -pt None -u 0.03312001859357557 > ./result_8chains/node104_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_0 -p 123 -st none -pt topic104_0_0 -u 0.009585010964110852 > ./result_8chains/node104_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_0 -p 365 -st none -pt topic104_1_0 -u 0.0264978851542908 > ./result_8chains/node104_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_0 -p 367 -st none -pt topic104_2_0 -u 0.012174824551205832 > ./result_8chains/node104_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_0 -p 449 -st none -pt topic104_3_0 -u 0.06545262745205771 > ./result_8chains/node104_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_0 -p 510 -st none -pt topic104_4_0 -u 0.0034693667095286873 > ./result_8chains/node104_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_0 -p 582 -st none -pt topic104_5_0 -u 0.0005492427893444285 > ./result_8chains/node104_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_0 -p 583 -st none -pt topic104_6_0 -u 0.058175008950247215 > ./result_8chains/node104_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_0 -p 710 -st none -pt topic104_7_0 -u 0.05749436912219271 > ./result_8chains/node104_7_0.txt &
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
    "./result_8chains/node104_0_0.txt 90"
    "./result_8chains/node104_0_2.txt 90"
    "./result_8chains/node104_1_0.txt 89"
    "./result_8chains/node104_1_2.txt 89"
    "./result_8chains/node104_2_0.txt 88"
    "./result_8chains/node104_2_2.txt 88"
    "./result_8chains/node104_3_0.txt 87"
    "./result_8chains/node104_3_2.txt 87"
    "./result_8chains/node104_4_0.txt 86"
    "./result_8chains/node104_4_2.txt 86"
    "./result_8chains/node104_5_0.txt 85"
    "./result_8chains/node104_5_2.txt 85"
    "./result_8chains/node104_6_0.txt 84"
    "./result_8chains/node104_6_2.txt 84"
    "./result_8chains/node104_7_0.txt 83"
    "./result_8chains/node104_7_2.txt 83"
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
