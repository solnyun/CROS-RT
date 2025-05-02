import sys

def read_data(filepath):
    """파일에서 데이터를 읽고 줄 목록을 반환합니다."""
    with open(filepath, 'r') as file:
        return [line.strip().split() for line in file]

def get_last_num(sub_path):
    """sub_path 파일의 마지막 줄의 두번째 토큰에서 숫자만 추출하여 반환합니다.
       토큰 형식은 "Data#<숫자>" 입니다.
    """
    with open(sub_path, 'r') as file:
        lines = [line for line in file if line.strip()]
    if not lines:
        return None
    last_line = lines[-1]
    tokens = last_line.strip().split()
    if len(tokens) < 2:
        return None
    token = tokens[2]  # 두 번째 토큰
    if token.startswith("Data#"):
        try:
            return int(token.split("#")[1])
        except ValueError:
            return None
    return None

def find_value(data, target, end_marker):
    """주어진 목표에 대한 값을 데이터에서 찾습니다."""
    for line in data:
        if line[2] == target and (line[1] == end_marker or line[1] == "pub"):
            return float(line[3])
    return 0.0

def main(sub_path, pub_path, output_path):
    print(sub_path)
    sub_data = read_data(sub_path)
    pub_data = read_data(pub_path)

    last_num = get_last_num(sub_path)
    if last_num is None:
        print("마지막 숫자 추출 실패")
        print(sub_path)
        sys.exit(1)

    if any(chain in output_path for chain in ["chain0"]):
        START_CNT = last_num - 300 if last_num - 300 > 0 else last_num - 50
    else:
        START_CNT = last_num - 200 if last_num - 200 > 0 else last_num - 50
    END_CNT = last_num - 1

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
