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
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_2 -p 30 -st topic292_0_1 -pt None -u 0.01976409182473543 > ./result_8chains/node292_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_2 -p 145 -st topic292_1_1 -pt None -u 0.011160350372749206 > ./result_8chains/node292_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_2 -p 363 -st topic292_2_1 -pt None -u 0.0025044188486763597 > ./result_8chains/node292_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_2 -p 607 -st topic292_3_1 -pt None -u 0.020988639032894524 > ./result_8chains/node292_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_2 -p 700 -st topic292_4_1 -pt None -u 0.0353431637776621 > ./result_8chains/node292_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_2 -p 857 -st topic292_5_1 -pt None -u 0.002338092557888416 > ./result_8chains/node292_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_2 -p 858 -st topic292_6_1 -pt None -u 0.005263924583684874 > ./result_8chains/node292_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_2 -p 953 -st topic292_7_1 -pt None -u 0.002199025531630321 > ./result_8chains/node292_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_0 -p 30 -st none -pt topic292_0_0 -u 0.038487773509090606 > ./result_8chains/node292_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_0 -p 145 -st none -pt topic292_1_0 -u 0.003154866827823455 > ./result_8chains/node292_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_0 -p 363 -st none -pt topic292_2_0 -u 0.0007266204824667444 > ./result_8chains/node292_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_0 -p 607 -st none -pt topic292_3_0 -u 0.1477081754601451 > ./result_8chains/node292_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_0 -p 700 -st none -pt topic292_4_0 -u 0.07033081032702046 > ./result_8chains/node292_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_0 -p 857 -st none -pt topic292_5_0 -u 0.0026808514992979204 > ./result_8chains/node292_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_0 -p 858 -st none -pt topic292_6_0 -u 8.704182061593235e-05 > ./result_8chains/node292_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_0 -p 953 -st none -pt topic292_7_0 -u 0.046065083526018735 > ./result_8chains/node292_7_0.txt &
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
    "./result_8chains/node292_0_0.txt 90"
    "./result_8chains/node292_0_2.txt 90"
    "./result_8chains/node292_1_0.txt 89"
    "./result_8chains/node292_1_2.txt 89"
    "./result_8chains/node292_2_0.txt 88"
    "./result_8chains/node292_2_2.txt 88"
    "./result_8chains/node292_3_0.txt 87"
    "./result_8chains/node292_3_2.txt 87"
    "./result_8chains/node292_4_0.txt 86"
    "./result_8chains/node292_4_2.txt 86"
    "./result_8chains/node292_5_0.txt 85"
    "./result_8chains/node292_5_2.txt 85"
    "./result_8chains/node292_6_0.txt 84"
    "./result_8chains/node292_6_2.txt 84"
    "./result_8chains/node292_7_0.txt 83"
    "./result_8chains/node292_7_2.txt 83"
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
