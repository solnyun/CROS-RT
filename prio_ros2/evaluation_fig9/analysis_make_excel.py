import pandas as pd
import os

directory = 'divide1_prio'
df_all = pd.DataFrame()

# vanilla와 framework 각각에 대한 파일을 읽고 DataFrame에 추가
for i in range(1, 5):
    vanilla_file_path = os.path.join(directory, f'vanilla_chain{i}.txt')
    framework_file_path = os.path.join(directory, f'framework_chain{i}.txt')
    
    # 두 번째 열(실수 값)만 읽기
    df_vanilla = pd.read_csv(vanilla_file_path, header=None, sep=" ", usecols=[1], names=[f'vanilla_chain{i}'])
    df_framework = pd.read_csv(framework_file_path, header=None, sep=" ", usecols=[1], names=[f'framework_chain{i}'])
    
    # 두 데이터프레임을 df_all에 병합
    df_all = pd.concat([df_all, df_vanilla, df_framework], axis=1)

# Excel 파일로 저장
df_all.to_excel('all_chain.xlsx', index=False)

