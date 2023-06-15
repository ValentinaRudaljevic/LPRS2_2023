import os
import shutil
import subprocess
import requests
import zipfile
import gdown

# Set the custom folder path
custom_folder = "/home/.arduino15/packages/max1000"

# Clone the Git repository folder
git_repo_url = "https://github.com/ValentinaRudaljevic/LPRS2_2023.git"
git_folder_path = f"{custom_folder}/git_folder"
hardware = f"{custom_folder}/hardware"
subprocess.run(["git", "clone", git_repo_url, git_folder_path])

git_custom_folder = os.path.join(custom_folder, "git_folder/Arduino_max1000_package")

shutil.move(git_custom_folder, hardware)

# Create the custom folder
os.makedirs(custom_folder, exist_ok=True)


# Nakon klonovanja foldera sa GitHub-a, pratiti flow.sh skriptu










