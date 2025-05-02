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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_2 -p 226 -st topic31_0_1 -pt None -u 0.00920800944438438 > ./result_10chains/node31_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_2 -p 439 -st topic31_1_1 -pt None -u 0.035300165752084445 > ./result_10chains/node31_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_2 -p 560 -st topic31_2_1 -pt None -u 0.016819301920802165 > ./result_10chains/node31_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_2 -p 627 -st topic31_3_1 -pt None -u 0.007456884381161488 > ./result_10chains/node31_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_2 -p 732 -st topic31_4_1 -pt None -u 0.008609954663982122 > ./result_10chains/node31_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_2 -p 758 -st topic31_5_1 -pt None -u 0.0020389121323328985 > ./result_10chains/node31_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_2 -p 819 -st topic31_6_1 -pt None -u 0.02743995666002659 > ./result_10chains/node31_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_2 -p 893 -st topic31_7_1 -pt None -u 0.005561538855713324 > ./result_10chains/node31_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_8_2 -p 943 -st topic31_8_1 -pt None -u 0.006948754000017238 > ./result_10chains/node31_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_9_2 -p 960 -st topic31_9_1 -pt None -u 0.015436590118259201 > ./result_10chains/node31_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_0 -p 226 -st none -pt topic31_0_0 -u 0.0029451971761373374 > ./result_10chains/node31_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_0 -p 439 -st none -pt topic31_1_0 -u 0.023619345687713844 > ./result_10chains/node31_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_0 -p 560 -st none -pt topic31_2_0 -u 0.030079149529622318 > ./result_10chains/node31_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_0 -p 627 -st none -pt topic31_3_0 -u 0.04029715153035035 > ./result_10chains/node31_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_0 -p 732 -st none -pt topic31_4_0 -u 0.006947028247315357 > ./result_10chains/node31_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_0 -p 758 -st none -pt topic31_5_0 -u 0.042506814665592835 > ./result_10chains/node31_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_0 -p 819 -st none -pt topic31_6_0 -u 0.0006699185724663992 > ./result_10chains/node31_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_0 -p 893 -st none -pt topic31_7_0 -u 0.03458855777628103 > ./result_10chains/node31_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_8_0 -p 943 -st none -pt topic31_8_0 -u 0.0018549176660335731 > ./result_10chains/node31_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_9_0 -p 960 -st none -pt topic31_9_0 -u 0.025161057326293795 > ./result_10chains/node31_9_0.txt &
sleep 10
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
    "./result_10chains/node31_0_0.txt 90"
    "./result_10chains/node31_0_2.txt 90"
    "./result_10chains/node31_1_0.txt 89"
    "./result_10chains/node31_1_2.txt 89"
    "./result_10chains/node31_2_0.txt 88"
    "./result_10chains/node31_2_2.txt 88"
    "./result_10chains/node31_3_0.txt 87"
    "./result_10chains/node31_3_2.txt 87"
    "./result_10chains/node31_4_0.txt 86"
    "./result_10chains/node31_4_2.txt 86"
    "./result_10chains/node31_5_0.txt 85"
    "./result_10chains/node31_5_2.txt 85"
    "./result_10chains/node31_6_0.txt 84"
    "./result_10chains/node31_6_2.txt 84"
    "./result_10chains/node31_7_0.txt 83"
    "./result_10chains/node31_7_2.txt 83"
    "./result_10chains/node31_8_0.txt 82"
    "./result_10chains/node31_8_2.txt 82"
    "./result_10chains/node31_9_0.txt 81"
    "./result_10chains/node31_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
