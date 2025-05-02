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
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_2 -p 89 -st topic457_0_1 -pt None -u 0.048029008103749604 > ./result_8chains/node457_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_2 -p 179 -st topic457_1_1 -pt None -u 0.010174682453924222 > ./result_8chains/node457_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_2 -p 401 -st topic457_2_1 -pt None -u 0.0076744244563692054 > ./result_8chains/node457_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_2 -p 428 -st topic457_3_1 -pt None -u 0.035928498867325076 > ./result_8chains/node457_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_2 -p 800 -st topic457_4_1 -pt None -u 0.019225534080681533 > ./result_8chains/node457_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_2 -p 879 -st topic457_5_1 -pt None -u 0.025682237629814753 > ./result_8chains/node457_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_6_2 -p 929 -st topic457_6_1 -pt None -u 0.002969106433505099 > ./result_8chains/node457_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_7_2 -p 937 -st topic457_7_1 -pt None -u 0.0098151811073917 > ./result_8chains/node457_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_0 -p 89 -st none -pt topic457_0_0 -u 0.0663475061400059 > ./result_8chains/node457_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_0 -p 179 -st none -pt topic457_1_0 -u 0.038867300421927375 > ./result_8chains/node457_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_0 -p 401 -st none -pt topic457_2_0 -u 0.014613239135512879 > ./result_8chains/node457_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_0 -p 428 -st none -pt topic457_3_0 -u 0.04424641272260543 > ./result_8chains/node457_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_0 -p 800 -st none -pt topic457_4_0 -u 0.014646160273228737 > ./result_8chains/node457_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_0 -p 879 -st none -pt topic457_5_0 -u 0.016288073547282747 > ./result_8chains/node457_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_6_0 -p 929 -st none -pt topic457_6_0 -u 0.018505517854066227 > ./result_8chains/node457_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node457_7_0 -p 937 -st none -pt topic457_7_0 -u 0.03999400192041147 > ./result_8chains/node457_7_0.txt &
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
    "./result_8chains/node457_0_0.txt 90"
    "./result_8chains/node457_0_2.txt 90"
    "./result_8chains/node457_1_0.txt 89"
    "./result_8chains/node457_1_2.txt 89"
    "./result_8chains/node457_2_0.txt 88"
    "./result_8chains/node457_2_2.txt 88"
    "./result_8chains/node457_3_0.txt 87"
    "./result_8chains/node457_3_2.txt 87"
    "./result_8chains/node457_4_0.txt 86"
    "./result_8chains/node457_4_2.txt 86"
    "./result_8chains/node457_5_0.txt 85"
    "./result_8chains/node457_5_2.txt 85"
    "./result_8chains/node457_6_0.txt 84"
    "./result_8chains/node457_6_2.txt 84"
    "./result_8chains/node457_7_0.txt 83"
    "./result_8chains/node457_7_2.txt 83"
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
