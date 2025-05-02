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
ros2 run evaluation_3_randomdag uunifast_node -n node161_0_2 -p 228 -st topic161_0_1 -pt None -u 0.020401309958650526 > ./result_8chains/node161_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_1_2 -p 298 -st topic161_1_1 -pt None -u 0.0004505440090264434 > ./result_8chains/node161_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_2_2 -p 675 -st topic161_2_1 -pt None -u 0.033473342957214935 > ./result_8chains/node161_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_3_2 -p 705 -st topic161_3_1 -pt None -u 0.0016412584866653535 > ./result_8chains/node161_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_4_2 -p 723 -st topic161_4_1 -pt None -u 0.004285567263691725 > ./result_8chains/node161_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_5_2 -p 852 -st topic161_5_1 -pt None -u 0.021331057555331517 > ./result_8chains/node161_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_6_2 -p 926 -st topic161_6_1 -pt None -u 0.04670171088851546 > ./result_8chains/node161_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_7_2 -p 959 -st topic161_7_1 -pt None -u 0.0035444876138942573 > ./result_8chains/node161_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_0_0 -p 228 -st none -pt topic161_0_0 -u 0.02034531478062318 > ./result_8chains/node161_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_1_0 -p 298 -st none -pt topic161_1_0 -u 0.02799390526585066 > ./result_8chains/node161_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_2_0 -p 675 -st none -pt topic161_2_0 -u 0.04082173556658131 > ./result_8chains/node161_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_3_0 -p 705 -st none -pt topic161_3_0 -u 0.016214211575410475 > ./result_8chains/node161_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_4_0 -p 723 -st none -pt topic161_4_0 -u 0.001446313964953705 > ./result_8chains/node161_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_5_0 -p 852 -st none -pt topic161_5_0 -u 0.04019912296234207 > ./result_8chains/node161_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_6_0 -p 926 -st none -pt topic161_6_0 -u 0.0528100228000358 > ./result_8chains/node161_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node161_7_0 -p 959 -st none -pt topic161_7_0 -u 0.05079091119763636 > ./result_8chains/node161_7_0.txt &
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
    "./result_8chains/node161_0_0.txt 90"
    "./result_8chains/node161_0_2.txt 90"
    "./result_8chains/node161_1_0.txt 89"
    "./result_8chains/node161_1_2.txt 89"
    "./result_8chains/node161_2_0.txt 88"
    "./result_8chains/node161_2_2.txt 88"
    "./result_8chains/node161_3_0.txt 87"
    "./result_8chains/node161_3_2.txt 87"
    "./result_8chains/node161_4_0.txt 86"
    "./result_8chains/node161_4_2.txt 86"
    "./result_8chains/node161_5_0.txt 85"
    "./result_8chains/node161_5_2.txt 85"
    "./result_8chains/node161_6_0.txt 84"
    "./result_8chains/node161_6_2.txt 84"
    "./result_8chains/node161_7_0.txt 83"
    "./result_8chains/node161_7_2.txt 83"
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
