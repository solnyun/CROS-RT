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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_2 -p 191 -st topic251_0_1 -pt None -u 0.00014926860391017982 > ./result_10chains/node251_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_2 -p 243 -st topic251_1_1 -pt None -u 0.03392151177932046 > ./result_10chains/node251_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_2 -p 296 -st topic251_2_1 -pt None -u 0.004932180893837179 > ./result_10chains/node251_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_2 -p 372 -st topic251_3_1 -pt None -u 0.025551120295211283 > ./result_10chains/node251_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_2 -p 475 -st topic251_4_1 -pt None -u 0.01430236596515344 > ./result_10chains/node251_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_2 -p 678 -st topic251_5_1 -pt None -u 0.007166809443964306 > ./result_10chains/node251_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_2 -p 941 -st topic251_6_1 -pt None -u 0.054117875122961706 > ./result_10chains/node251_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_2 -p 948 -st topic251_7_1 -pt None -u 0.03059031060780322 > ./result_10chains/node251_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_8_2 -p 950 -st topic251_8_1 -pt None -u 0.004782871029708841 > ./result_10chains/node251_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_9_2 -p 953 -st topic251_9_1 -pt None -u 0.04026822794868879 > ./result_10chains/node251_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_0 -p 191 -st none -pt topic251_0_0 -u 0.003798798889855237 > ./result_10chains/node251_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_0 -p 243 -st none -pt topic251_1_0 -u 0.012132592442877288 > ./result_10chains/node251_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_0 -p 296 -st none -pt topic251_2_0 -u 0.003553429549293885 > ./result_10chains/node251_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_0 -p 372 -st none -pt topic251_3_0 -u 0.01083565601341091 > ./result_10chains/node251_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_0 -p 475 -st none -pt topic251_4_0 -u 0.01644572275828332 > ./result_10chains/node251_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_0 -p 678 -st none -pt topic251_5_0 -u 0.0054119349798469885 > ./result_10chains/node251_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_0 -p 941 -st none -pt topic251_6_0 -u 8.794639885761901e-05 > ./result_10chains/node251_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_0 -p 948 -st none -pt topic251_7_0 -u 0.006699488595417108 > ./result_10chains/node251_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_8_0 -p 950 -st none -pt topic251_8_0 -u 0.017214095181788264 > ./result_10chains/node251_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_9_0 -p 953 -st none -pt topic251_9_0 -u 0.029150582708924615 > ./result_10chains/node251_9_0.txt &
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
    "./result_10chains/node251_0_0.txt 90"
    "./result_10chains/node251_0_2.txt 90"
    "./result_10chains/node251_1_0.txt 89"
    "./result_10chains/node251_1_2.txt 89"
    "./result_10chains/node251_2_0.txt 88"
    "./result_10chains/node251_2_2.txt 88"
    "./result_10chains/node251_3_0.txt 87"
    "./result_10chains/node251_3_2.txt 87"
    "./result_10chains/node251_4_0.txt 86"
    "./result_10chains/node251_4_2.txt 86"
    "./result_10chains/node251_5_0.txt 85"
    "./result_10chains/node251_5_2.txt 85"
    "./result_10chains/node251_6_0.txt 84"
    "./result_10chains/node251_6_2.txt 84"
    "./result_10chains/node251_7_0.txt 83"
    "./result_10chains/node251_7_2.txt 83"
    "./result_10chains/node251_8_0.txt 82"
    "./result_10chains/node251_8_2.txt 82"
    "./result_10chains/node251_9_0.txt 81"
    "./result_10chains/node251_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
