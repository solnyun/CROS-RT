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
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_2 -p 323 -st topic65_0_1 -pt None -u 0.006827546157078812 > ./result_10chains/node65_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_2 -p 357 -st topic65_1_1 -pt None -u 0.005147395001362742 > ./result_10chains/node65_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_2 -p 520 -st topic65_2_1 -pt None -u 0.007526507530056403 > ./result_10chains/node65_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_2 -p 636 -st topic65_3_1 -pt None -u 0.0038848817266097235 > ./result_10chains/node65_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_2 -p 664 -st topic65_4_1 -pt None -u 0.027421700546653438 > ./result_10chains/node65_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_2 -p 670 -st topic65_5_1 -pt None -u 0.03626805563476293 > ./result_10chains/node65_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_2 -p 682 -st topic65_6_1 -pt None -u 0.0011822936315711852 > ./result_10chains/node65_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_2 -p 701 -st topic65_7_1 -pt None -u 0.006178250765306759 > ./result_10chains/node65_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_8_2 -p 814 -st topic65_8_1 -pt None -u 0.03961728258957656 > ./result_10chains/node65_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_9_2 -p 922 -st topic65_9_1 -pt None -u 0.006730388593214762 > ./result_10chains/node65_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_0 -p 323 -st none -pt topic65_0_0 -u 0.005423948966962522 > ./result_10chains/node65_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_0 -p 357 -st none -pt topic65_1_0 -u 0.0020316350889035273 > ./result_10chains/node65_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_0 -p 520 -st none -pt topic65_2_0 -u 0.005184914389335327 > ./result_10chains/node65_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_0 -p 636 -st none -pt topic65_3_0 -u 0.004219601856039257 > ./result_10chains/node65_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_0 -p 664 -st none -pt topic65_4_0 -u 0.0038702974278014834 > ./result_10chains/node65_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_0 -p 670 -st none -pt topic65_5_0 -u 0.0401899027119203 > ./result_10chains/node65_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_0 -p 682 -st none -pt topic65_6_0 -u 0.00679767971021028 > ./result_10chains/node65_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_0 -p 701 -st none -pt topic65_7_0 -u 0.010442652704847094 > ./result_10chains/node65_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_8_0 -p 814 -st none -pt topic65_8_0 -u 0.04018715097368589 > ./result_10chains/node65_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_9_0 -p 922 -st none -pt topic65_9_0 -u 0.08101326953045507 > ./result_10chains/node65_9_0.txt &
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
    "./result_10chains/node65_0_0.txt 90"
    "./result_10chains/node65_0_2.txt 90"
    "./result_10chains/node65_1_0.txt 89"
    "./result_10chains/node65_1_2.txt 89"
    "./result_10chains/node65_2_0.txt 88"
    "./result_10chains/node65_2_2.txt 88"
    "./result_10chains/node65_3_0.txt 87"
    "./result_10chains/node65_3_2.txt 87"
    "./result_10chains/node65_4_0.txt 86"
    "./result_10chains/node65_4_2.txt 86"
    "./result_10chains/node65_5_0.txt 85"
    "./result_10chains/node65_5_2.txt 85"
    "./result_10chains/node65_6_0.txt 84"
    "./result_10chains/node65_6_2.txt 84"
    "./result_10chains/node65_7_0.txt 83"
    "./result_10chains/node65_7_2.txt 83"
    "./result_10chains/node65_8_0.txt 82"
    "./result_10chains/node65_8_2.txt 82"
    "./result_10chains/node65_9_0.txt 81"
    "./result_10chains/node65_9_2.txt 81"
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
