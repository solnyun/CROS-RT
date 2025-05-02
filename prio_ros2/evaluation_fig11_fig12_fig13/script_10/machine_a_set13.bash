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
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_2 -p 262 -st topic13_0_1 -pt None -u 0.0168332749825037 > ./result_10chains/node13_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_2 -p 346 -st topic13_1_1 -pt None -u 0.012535936171546247 > ./result_10chains/node13_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_2 -p 441 -st topic13_2_1 -pt None -u 0.009475081889438741 > ./result_10chains/node13_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_2 -p 638 -st topic13_3_1 -pt None -u 0.005730777569205703 > ./result_10chains/node13_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_2 -p 734 -st topic13_4_1 -pt None -u 0.013278478076749256 > ./result_10chains/node13_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_2 -p 745 -st topic13_5_1 -pt None -u 0.021330910541924347 > ./result_10chains/node13_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_6_2 -p 790 -st topic13_6_1 -pt None -u 0.004776762204837887 > ./result_10chains/node13_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_7_2 -p 832 -st topic13_7_1 -pt None -u 0.010619383291276194 > ./result_10chains/node13_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_8_2 -p 908 -st topic13_8_1 -pt None -u 0.0013645157645327775 > ./result_10chains/node13_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_9_2 -p 943 -st topic13_9_1 -pt None -u 0.003621575117329073 > ./result_10chains/node13_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_0 -p 262 -st none -pt topic13_0_0 -u 0.04852127438960513 > ./result_10chains/node13_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_0 -p 346 -st none -pt topic13_1_0 -u 0.02183247387699694 > ./result_10chains/node13_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_0 -p 441 -st none -pt topic13_2_0 -u 0.006567113777258271 > ./result_10chains/node13_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_0 -p 638 -st none -pt topic13_3_0 -u 0.03281861654683388 > ./result_10chains/node13_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_0 -p 734 -st none -pt topic13_4_0 -u 0.00565561112304247 > ./result_10chains/node13_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_0 -p 745 -st none -pt topic13_5_0 -u 0.013770149320099484 > ./result_10chains/node13_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_6_0 -p 790 -st none -pt topic13_6_0 -u 0.0059989365811137785 > ./result_10chains/node13_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_7_0 -p 832 -st none -pt topic13_7_0 -u 0.0070484322358668056 > ./result_10chains/node13_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_8_0 -p 908 -st none -pt topic13_8_0 -u 0.04366561853940286 > ./result_10chains/node13_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_9_0 -p 943 -st none -pt topic13_9_0 -u 0.0015779498603251743 > ./result_10chains/node13_9_0.txt &
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
    "./result_10chains/node13_0_0.txt 90"
    "./result_10chains/node13_0_2.txt 90"
    "./result_10chains/node13_1_0.txt 89"
    "./result_10chains/node13_1_2.txt 89"
    "./result_10chains/node13_2_0.txt 88"
    "./result_10chains/node13_2_2.txt 88"
    "./result_10chains/node13_3_0.txt 87"
    "./result_10chains/node13_3_2.txt 87"
    "./result_10chains/node13_4_0.txt 86"
    "./result_10chains/node13_4_2.txt 86"
    "./result_10chains/node13_5_0.txt 85"
    "./result_10chains/node13_5_2.txt 85"
    "./result_10chains/node13_6_0.txt 84"
    "./result_10chains/node13_6_2.txt 84"
    "./result_10chains/node13_7_0.txt 83"
    "./result_10chains/node13_7_2.txt 83"
    "./result_10chains/node13_8_0.txt 82"
    "./result_10chains/node13_8_2.txt 82"
    "./result_10chains/node13_9_0.txt 81"
    "./result_10chains/node13_9_2.txt 81"
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
