import sys

def read_data(filepath):
    """파일에서 데이터를 읽고 줄 목록을 반환합니다."""
    with open(filepath, 'r') as file:
        return [line.strip().split() for line in file]

def find_value(data, target, end_marker):
    """주어진 목표에 대한 값을 데이터에서 찾습니다."""
    for line in data:
        if line[2] == target and (line[1] == end_marker or line[1] == "pub"):
            return float(line[3])
    return 0.0

def main(sub_path, pub_path, output_path):
    sub_data = read_data(sub_path)
    pub_data = read_data(pub_path)

    if any(chain in output_path for chain in ["chain4"]):
        START_CNT = 100
        END_CNT = 400
    elif any(chain in output_path for chain in ["chain2"]):
        START_CNT = 40
        END_CNT = 4000
    else:
        START_CNT = 300
        END_CNT = 4000
    END_MARKER = "end"

    with open(output_path, 'w') as output_file:
        for cnt in range(START_CNT, END_CNT + 1):
            data_id = f"Data#{cnt}"
            sub_value = find_value(sub_data, data_id, END_MARKER)
            pub_value = find_value(pub_data, data_id, None)

            diff = (sub_value - pub_value) * 1000 if sub_value - pub_value >= 0 else 100000
            output_line = f"{data_id} {diff}\n"
            output_file.write(output_line)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python3 e2e.py <sub_path> <pub_path> <output_path>")
        sys.exit(1)

    sub_path, pub_path, output_path = sys.argv[1:4]
    main(sub_path, pub_path, output_path)

