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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_2 -p 150 -st topic414_0_1 -pt None -u 0.02928685758700933 > ./result_10chains/node414_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_2 -p 287 -st topic414_1_1 -pt None -u 0.019640711312112813 > ./result_10chains/node414_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_2 -p 289 -st topic414_2_1 -pt None -u 0.009042923732206887 > ./result_10chains/node414_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_2 -p 419 -st topic414_3_1 -pt None -u 0.02094719997592731 > ./result_10chains/node414_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_2 -p 437 -st topic414_4_1 -pt None -u 0.010713865956073099 > ./result_10chains/node414_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_2 -p 658 -st topic414_5_1 -pt None -u 0.024067077144906524 > ./result_10chains/node414_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_2 -p 780 -st topic414_6_1 -pt None -u 0.025613686952599024 > ./result_10chains/node414_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_2 -p 786 -st topic414_7_1 -pt None -u 0.006065130981526348 > ./result_10chains/node414_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_8_2 -p 834 -st topic414_8_1 -pt None -u 0.00686676981154296 > ./result_10chains/node414_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_9_2 -p 917 -st topic414_9_1 -pt None -u 0.004304290189076253 > ./result_10chains/node414_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_0 -p 150 -st none -pt topic414_0_0 -u 0.014440650986091097 > ./result_10chains/node414_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_0 -p 287 -st none -pt topic414_1_0 -u 0.0003540899089975458 > ./result_10chains/node414_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_0 -p 289 -st none -pt topic414_2_0 -u 0.010993154522890958 > ./result_10chains/node414_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_0 -p 419 -st none -pt topic414_3_0 -u 0.00036028532978210626 > ./result_10chains/node414_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_0 -p 437 -st none -pt topic414_4_0 -u 0.0006622292340295322 > ./result_10chains/node414_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_0 -p 658 -st none -pt topic414_5_0 -u 0.03793846273812748 > ./result_10chains/node414_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_0 -p 780 -st none -pt topic414_6_0 -u 0.013525556353619794 > ./result_10chains/node414_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_0 -p 786 -st none -pt topic414_7_0 -u 0.01842629725268949 > ./result_10chains/node414_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_8_0 -p 834 -st none -pt topic414_8_0 -u 0.07654723353846028 > ./result_10chains/node414_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_9_0 -p 917 -st none -pt topic414_9_0 -u 0.0006395053339224264 > ./result_10chains/node414_9_0.txt &
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
    "./result_10chains/node414_0_0.txt 90"
    "./result_10chains/node414_0_2.txt 90"
    "./result_10chains/node414_1_0.txt 89"
    "./result_10chains/node414_1_2.txt 89"
    "./result_10chains/node414_2_0.txt 88"
    "./result_10chains/node414_2_2.txt 88"
    "./result_10chains/node414_3_0.txt 87"
    "./result_10chains/node414_3_2.txt 87"
    "./result_10chains/node414_4_0.txt 86"
    "./result_10chains/node414_4_2.txt 86"
    "./result_10chains/node414_5_0.txt 85"
    "./result_10chains/node414_5_2.txt 85"
    "./result_10chains/node414_6_0.txt 84"
    "./result_10chains/node414_6_2.txt 84"
    "./result_10chains/node414_7_0.txt 83"
    "./result_10chains/node414_7_2.txt 83"
    "./result_10chains/node414_8_0.txt 82"
    "./result_10chains/node414_8_2.txt 82"
    "./result_10chains/node414_9_0.txt 81"
    "./result_10chains/node414_9_2.txt 81"
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
