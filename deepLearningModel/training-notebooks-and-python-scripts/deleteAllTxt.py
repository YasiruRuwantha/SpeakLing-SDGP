import os
import shutil

def remove_txt_files(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.txt'):
                os.remove(os.path.join(root, file))
    print('All .txt files removed successfully!')

# Example usage
remove_txt_files('E:/wav2vec2 datasets/data')