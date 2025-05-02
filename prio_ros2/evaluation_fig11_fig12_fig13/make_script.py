import os
import re
import sys

def append_priority_commands(input_directory):
    header = (
        "#!/bin/bash\n\n"
        "# Print usage information and exit\n"
        "print_usage() {\n"
        "    echo \"Usage: $0 <vanilla|framework> <with_nonRT_pl|no>\"\n"
        "    exit 1\n"
        "}\n\n"
        "if [ \"$#\" -ne 2 ]; then\n"
        "    print_usage\n"
        "fi\n\n"
        "type=$1\n"
        "model=$2\n\n"
        "# Create a directory to store the result data\n"
        "# CreateDIR=result/\n"
        "# if [ ! -d \"$CreateDIR\" ]; then\n"
        "#    mkdir \"$CreateDIR\"\n"
        "# fi\n"
    )

    finalize_framework_function = (
        "finalize_framework() {\n"
        "    if [ \"$type\" == \"framework\" ]; then\n"
        "        if [ \"$model\" == \"with_nonRT\" ]; then\n"
        "            python3 pri_remove.py \"$file_name_motor\"\n"
        "        fi\n"
        "        for filepath in \"${files[@]}\"; do\n"
        "            file=$(echo \"$filepath\" | cut -d' ' -f1)\n"
        "            python3 pri_remove.py \"$file\"\n"
        "        done\n"
        "    fi\n"
        "}\n\n"
    )

    # node filename pattern: e.g., node0_1_2.txt
    node_re = re.compile(r'node(\d+)_(\d+)_(\d+)\.txt')

    # Regex for machine_a_set and machine_b_set filenames
    machine_a_re = re.compile(r'^machine_a_set\d+\.bash$')
    machine_b_re = re.compile(r'^machine_b_set\d+\.bash$')

    for filename in os.listdir(input_directory):
        if filename.endswith(".bash"):
            filepath = os.path.join(input_directory, filename)

            # Determine if current file matches machine_a_set or machine_b_set
            is_machine_a = machine_a_re.match(filename) is not None
            is_machine_b = machine_b_re.match(filename) is not None

            with open(filepath, 'r') as file:
                lines = file.readlines()

            # --- [1] Rearranging ros2 run commands ---
            # Find lines that contain "ros2 run" with a node filename and store with index.
            ros2_data = []
            for i, line in enumerate(lines):
                if "ros2 run" in line:
                    m = node_re.search(line)
                    if m:
                        # Extract numbers from node<num1>_<num2>_<num3>.txt (assuming num1 is identical)
                        num1 = int(m.group(1))
                        num2 = int(m.group(2))
                        num3 = int(m.group(3))
                        ros2_data.append((i, line, num3, num2))
            # If one or more "ros2 run" commands exist…
            if ros2_data:
                # Sort by num3 descending, and if equal, by num2 ascending.
                sorted_ros2 = sorted(ros2_data, key=lambda x: (-x[2], x[3]))
                # Extract indices in the original order (ascending order of indices)
                ros2_indices = [t[0] for t in sorted(ros2_data, key=lambda x: x[0])]
                # Replace the original lines (in the order of indices) with the sorted commands.
                for idx, new_cmd in zip(ros2_indices, [t[1] for t in sorted_ros2]):
                    lines[idx] = new_cmd
            # --- [1] end ---

            # --- [2] Priority assignments (original code) ---
            period_regex = re.compile(r'-p (\d+)')
            filename_regex = re.compile(r'> (\./result_[^ ]+\.txt)')
            periods_and_files = []
            for line in lines:
                period_match = period_regex.search(line)
                file_match = filename_regex.search(line)
                if period_match and file_match:
                    period = int(period_match.group(1))
                    file_path = file_match.group(1)
                    periods_and_files.append((period, file_path))
            periods_and_files.sort()
            if periods_and_files:
                unique_periods = sorted(set(p for p, _ in periods_and_files))
                period_to_priority = {p: 90 - i for i, p in enumerate(unique_periods)}
                priority_assignments = []
                for period, file_path in periods_and_files:
                    priority_assignments.append((file_path, period_to_priority[period]))
            else:
                priority_assignments = []
            # --- [2] end ---

            # --- [3] Construct final script content ---
            content = []
            content.append(header)
            content.extend(lines)
            content.append(finalize_framework_function)

            content.append("\n# Priority Assignments\n")
            content.append("declare -a files=(\n")
            for fp, prio in priority_assignments:
                content.append(f"    \"{fp} {prio}\"\n")
            content.append(")\n\n")
            content.append("for filepath in \"${files[@]}\"; do\n")
            content.append("    file=$(echo \"$filepath\" | cut -d' ' -f1)\n")
            content.append("    priority=$(echo \"$filepath\" | cut -d' ' -f2)\n")
            content.append("    if [ \"$type\" == \"vanilla\" ]; then\n")
            content.append("        python3 pri_assign.py $file $priority\n")
            content.append("    elif [ \"$type\" == \"framework\" ]; then\n")
            content.append("        python3 pri_identifier.py $file $priority\n")
            content.append("    fi\n")
            content.append("done\n")
            content.append("echo \"End Priority Assignment\"\n")

            content.append("\n# Finalize by performing a final command and killing any remaining processes\n")
            if is_machine_b:
                # For machine_b_set*.bash, replace "sleep 100s" with the following send_signal command.
                content.append("/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797\n")
            else:
                content.append("sleep 190s\n")
                content.append("sudo pkill -USR1 uunifast_node\n")
                content.append("echo \"Set timer signal!\"\n")
                content.append("sleep 200s\n")
            content.append("echo \"End Running\"\n")
            content.append("sudo pkill uunifast_node\n")
            content.append("finalize_framework\n")
            if is_machine_a:
                # For machine_a_set*.bash, use send_signal with specified IP.
                content.append("/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999\n")
            # --- [3] end ---

            with open(filepath, 'w') as file:
                file.writelines(content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python append_priority_commands.py <input_directory>")
        sys.exit(1)

    input_directory = sys.argv[1]
    append_priority_commands(input_directory)

