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
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_2 -p 115 -st topic257_0_1 -pt None -u 0.006452995527728933 > ./result_10chains/node257_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_2 -p 185 -st topic257_1_1 -pt None -u 0.0002783845181308364 > ./result_10chains/node257_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_2 -p 189 -st topic257_2_1 -pt None -u 0.0835360765934463 > ./result_10chains/node257_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_2 -p 212 -st topic257_3_1 -pt None -u 0.03667315519142322 > ./result_10chains/node257_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_2 -p 225 -st topic257_4_1 -pt None -u 0.01872913135244131 > ./result_10chains/node257_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_2 -p 363 -st topic257_5_1 -pt None -u 0.0049617874000142115 > ./result_10chains/node257_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_6_2 -p 502 -st topic257_6_1 -pt None -u 0.012362159745521961 > ./result_10chains/node257_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_7_2 -p 664 -st topic257_7_1 -pt None -u 0.006619939782139872 > ./result_10chains/node257_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_8_2 -p 693 -st topic257_8_1 -pt None -u 0.0010929154051989992 > ./result_10chains/node257_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_9_2 -p 747 -st topic257_9_1 -pt None -u 0.016307169674999292 > ./result_10chains/node257_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_0 -p 115 -st none -pt topic257_0_0 -u 0.06021016452313138 > ./result_10chains/node257_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_0 -p 185 -st none -pt topic257_1_0 -u 0.00809438306152177 > ./result_10chains/node257_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_0 -p 189 -st none -pt topic257_2_0 -u 0.008667930359587128 > ./result_10chains/node257_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_0 -p 212 -st none -pt topic257_3_0 -u 0.028737964393548976 > ./result_10chains/node257_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_0 -p 225 -st none -pt topic257_4_0 -u 0.0051525142360720755 > ./result_10chains/node257_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_0 -p 363 -st none -pt topic257_5_0 -u 0.002224948688662659 > ./result_10chains/node257_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_6_0 -p 502 -st none -pt topic257_6_0 -u 0.01860168081367397 > ./result_10chains/node257_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_7_0 -p 664 -st none -pt topic257_7_0 -u 0.02926074038903112 > ./result_10chains/node257_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_8_0 -p 693 -st none -pt topic257_8_0 -u 0.025655565468520505 > ./result_10chains/node257_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_9_0 -p 747 -st none -pt topic257_9_0 -u 0.004712489174904508 > ./result_10chains/node257_9_0.txt &
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
    "./result_10chains/node257_0_0.txt 90"
    "./result_10chains/node257_0_2.txt 90"
    "./result_10chains/node257_1_0.txt 89"
    "./result_10chains/node257_1_2.txt 89"
    "./result_10chains/node257_2_0.txt 88"
    "./result_10chains/node257_2_2.txt 88"
    "./result_10chains/node257_3_0.txt 87"
    "./result_10chains/node257_3_2.txt 87"
    "./result_10chains/node257_4_0.txt 86"
    "./result_10chains/node257_4_2.txt 86"
    "./result_10chains/node257_5_0.txt 85"
    "./result_10chains/node257_5_2.txt 85"
    "./result_10chains/node257_6_0.txt 84"
    "./result_10chains/node257_6_2.txt 84"
    "./result_10chains/node257_7_0.txt 83"
    "./result_10chains/node257_7_2.txt 83"
    "./result_10chains/node257_8_0.txt 82"
    "./result_10chains/node257_8_2.txt 82"
    "./result_10chains/node257_9_0.txt 81"
    "./result_10chains/node257_9_2.txt 81"
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
