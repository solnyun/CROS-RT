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
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_2 -p 33 -st topic314_0_1 -pt None -u 0.001752586657806976 > ./result_8chains/node314_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_2 -p 128 -st topic314_1_1 -pt None -u 0.02646693804234662 > ./result_8chains/node314_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_2 -p 257 -st topic314_2_1 -pt None -u 0.004245959281912126 > ./result_8chains/node314_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_2 -p 578 -st topic314_3_1 -pt None -u 0.022443118917895022 > ./result_8chains/node314_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_2 -p 662 -st topic314_4_1 -pt None -u 0.009479066596722818 > ./result_8chains/node314_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_2 -p 775 -st topic314_5_1 -pt None -u 0.0011089806662037127 > ./result_8chains/node314_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_6_2 -p 808 -st topic314_6_1 -pt None -u 0.035298582194947914 > ./result_8chains/node314_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_7_2 -p 921 -st topic314_7_1 -pt None -u 0.05129522611213653 > ./result_8chains/node314_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_0 -p 33 -st none -pt topic314_0_0 -u 0.0491664463923997 > ./result_8chains/node314_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_0 -p 128 -st none -pt topic314_1_0 -u 0.011223162393364572 > ./result_8chains/node314_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_0 -p 257 -st none -pt topic314_2_0 -u 0.001675499713444828 > ./result_8chains/node314_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_0 -p 578 -st none -pt topic314_3_0 -u 0.05183377758307972 > ./result_8chains/node314_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_0 -p 662 -st none -pt topic314_4_0 -u 0.006847779279724742 > ./result_8chains/node314_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_0 -p 775 -st none -pt topic314_5_0 -u 0.010846184562039646 > ./result_8chains/node314_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_6_0 -p 808 -st none -pt topic314_6_0 -u 0.0064091386554962215 > ./result_8chains/node314_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_7_0 -p 921 -st none -pt topic314_7_0 -u 0.07540204896648414 > ./result_8chains/node314_7_0.txt &
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
    "./result_8chains/node314_0_0.txt 90"
    "./result_8chains/node314_0_2.txt 90"
    "./result_8chains/node314_1_0.txt 89"
    "./result_8chains/node314_1_2.txt 89"
    "./result_8chains/node314_2_0.txt 88"
    "./result_8chains/node314_2_2.txt 88"
    "./result_8chains/node314_3_0.txt 87"
    "./result_8chains/node314_3_2.txt 87"
    "./result_8chains/node314_4_0.txt 86"
    "./result_8chains/node314_4_2.txt 86"
    "./result_8chains/node314_5_0.txt 85"
    "./result_8chains/node314_5_2.txt 85"
    "./result_8chains/node314_6_0.txt 84"
    "./result_8chains/node314_6_2.txt 84"
    "./result_8chains/node314_7_0.txt 83"
    "./result_8chains/node314_7_2.txt 83"
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
