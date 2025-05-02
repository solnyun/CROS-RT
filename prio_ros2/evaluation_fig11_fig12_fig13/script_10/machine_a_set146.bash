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
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_2 -p 83 -st topic146_0_1 -pt None -u 0.007804147801450501 > ./result_10chains/node146_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_2 -p 108 -st topic146_1_1 -pt None -u 0.002007731730712392 > ./result_10chains/node146_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_2 -p 201 -st topic146_2_1 -pt None -u 0.0020641377474331923 > ./result_10chains/node146_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_2 -p 309 -st topic146_3_1 -pt None -u 0.029628996393043394 > ./result_10chains/node146_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_2 -p 425 -st topic146_4_1 -pt None -u 0.026929551125366186 > ./result_10chains/node146_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_2 -p 539 -st topic146_5_1 -pt None -u 0.025306366207196757 > ./result_10chains/node146_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_6_2 -p 732 -st topic146_6_1 -pt None -u 0.00038508551912641575 > ./result_10chains/node146_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_7_2 -p 772 -st topic146_7_1 -pt None -u 0.000904863132160566 > ./result_10chains/node146_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_8_2 -p 876 -st topic146_8_1 -pt None -u 0.006293836879674206 > ./result_10chains/node146_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_9_2 -p 941 -st topic146_9_1 -pt None -u 0.01933709098290248 > ./result_10chains/node146_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_0 -p 83 -st none -pt topic146_0_0 -u 0.00236935293945717 > ./result_10chains/node146_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_0 -p 108 -st none -pt topic146_1_0 -u 0.03321674005511477 > ./result_10chains/node146_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_0 -p 201 -st none -pt topic146_2_0 -u 0.07357697706155875 > ./result_10chains/node146_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_0 -p 309 -st none -pt topic146_3_0 -u 0.006943816550683379 > ./result_10chains/node146_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_0 -p 425 -st none -pt topic146_4_0 -u 0.005143923656948823 > ./result_10chains/node146_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_0 -p 539 -st none -pt topic146_5_0 -u 0.01807837137712534 > ./result_10chains/node146_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_6_0 -p 732 -st none -pt topic146_6_0 -u 0.0012296229218084764 > ./result_10chains/node146_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_7_0 -p 772 -st none -pt topic146_7_0 -u 0.0032305014903649953 > ./result_10chains/node146_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_8_0 -p 876 -st none -pt topic146_8_0 -u 0.0559079501350601 > ./result_10chains/node146_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_9_0 -p 941 -st none -pt topic146_9_0 -u 0.02730148648282283 > ./result_10chains/node146_9_0.txt &
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
    "./result_10chains/node146_0_0.txt 90"
    "./result_10chains/node146_0_2.txt 90"
    "./result_10chains/node146_1_0.txt 89"
    "./result_10chains/node146_1_2.txt 89"
    "./result_10chains/node146_2_0.txt 88"
    "./result_10chains/node146_2_2.txt 88"
    "./result_10chains/node146_3_0.txt 87"
    "./result_10chains/node146_3_2.txt 87"
    "./result_10chains/node146_4_0.txt 86"
    "./result_10chains/node146_4_2.txt 86"
    "./result_10chains/node146_5_0.txt 85"
    "./result_10chains/node146_5_2.txt 85"
    "./result_10chains/node146_6_0.txt 84"
    "./result_10chains/node146_6_2.txt 84"
    "./result_10chains/node146_7_0.txt 83"
    "./result_10chains/node146_7_2.txt 83"
    "./result_10chains/node146_8_0.txt 82"
    "./result_10chains/node146_8_2.txt 82"
    "./result_10chains/node146_9_0.txt 81"
    "./result_10chains/node146_9_2.txt 81"
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
