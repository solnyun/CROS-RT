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
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_2 -p 262 -st topic495_0_1 -pt None -u 0.021680312964121373 > ./result_8chains/node495_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_2 -p 447 -st topic495_1_1 -pt None -u 0.041958274428245956 > ./result_8chains/node495_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_2 -p 492 -st topic495_2_1 -pt None -u 0.003347863566056264 > ./result_8chains/node495_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_2 -p 539 -st topic495_3_1 -pt None -u 0.021979450156369262 > ./result_8chains/node495_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_2 -p 592 -st topic495_4_1 -pt None -u 0.02449972675220141 > ./result_8chains/node495_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_2 -p 727 -st topic495_5_1 -pt None -u 0.0014159536803316913 > ./result_8chains/node495_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_2 -p 779 -st topic495_6_1 -pt None -u 0.0037447583494135406 > ./result_8chains/node495_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_2 -p 791 -st topic495_7_1 -pt None -u 0.018614048339884847 > ./result_8chains/node495_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_0 -p 262 -st none -pt topic495_0_0 -u 0.005669516316916701 > ./result_8chains/node495_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_0 -p 447 -st none -pt topic495_1_0 -u 0.0013037817229732407 > ./result_8chains/node495_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_0 -p 492 -st none -pt topic495_2_0 -u 0.03127468696081842 > ./result_8chains/node495_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_0 -p 539 -st none -pt topic495_3_0 -u 0.051994189442579664 > ./result_8chains/node495_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_0 -p 592 -st none -pt topic495_4_0 -u 0.009661372638444798 > ./result_8chains/node495_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_0 -p 727 -st none -pt topic495_5_0 -u 0.06794943126230499 > ./result_8chains/node495_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_0 -p 779 -st none -pt topic495_6_0 -u 0.009832619673730891 > ./result_8chains/node495_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_0 -p 791 -st none -pt topic495_7_0 -u 0.06629288335497775 > ./result_8chains/node495_7_0.txt &
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
    "./result_8chains/node495_0_0.txt 90"
    "./result_8chains/node495_0_2.txt 90"
    "./result_8chains/node495_1_0.txt 89"
    "./result_8chains/node495_1_2.txt 89"
    "./result_8chains/node495_2_0.txt 88"
    "./result_8chains/node495_2_2.txt 88"
    "./result_8chains/node495_3_0.txt 87"
    "./result_8chains/node495_3_2.txt 87"
    "./result_8chains/node495_4_0.txt 86"
    "./result_8chains/node495_4_2.txt 86"
    "./result_8chains/node495_5_0.txt 85"
    "./result_8chains/node495_5_2.txt 85"
    "./result_8chains/node495_6_0.txt 84"
    "./result_8chains/node495_6_2.txt 84"
    "./result_8chains/node495_7_0.txt 83"
    "./result_8chains/node495_7_2.txt 83"
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
