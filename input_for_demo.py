import subprocess
import os
import public_ip as ip
import argparse


def run_terraform_create():
    pub_ip = f"public_ip={ip.get()}/32"
    subprocess.run(["terraform", "plan", "-var", pub_ip, "-out", "my_plan"])
    subprocess.run(["terraform", "apply", "my_plan"])


def create_user_data_file(user_data_file="user_data.sh", init_file="init.sh", file_to_append_to_init="index.php"):
    # open the files
    f1 = open(init_file, 'r')
    f2 = open(file_to_append_to_init, 'r')
    f3 = open(user_data_file, 'w')
    # perform modifications
    f3.write(f1.read())
    f3.write("\ncat << EOF > /var/www/html/index.php\n")
    f3.write(f2.read())
    f3.write("\nEOF")
    # relocating the cursor of the file at the beginning
    f3.seek(0)
    # closing the files
    f1.close()
    f2.close()
    f3.close()


def invoke_setup_functions(environment, file_to_append="index.php"):
    print(f"Creating {environment} setup")
    create_user_data_file(file_to_append_to_init=file_to_append)
    run_terraform_create()
    print("Setup completed.")


os.chdir(path='terraform')
parser = argparse.ArgumentParser()
parser.add_argument('--environment', type=str, choices=['initial', 'blacklist_code_fix', 'whitelist_code_fix',
                                                        'final_code_fix', 'aws_infra_fix', 'aws_firewall_fix'],
                    required=True)
args = parser.parse_args()
user_environment = args.environment

if user_environment == "initial":
    invoke_setup_functions(environment=user_environment)
elif user_environment == "blacklist_code_fix":
    invoke_setup_functions(environment=user_environment, file_to_append="index_blacklist.php")
elif user_environment == "whitelist_code_fix":
    invoke_setup_functions(environment=user_environment, file_to_append="index_fix.php")
elif user_environment == "final_code_fix":
    invoke_setup_functions(environment=user_environment, file_to_append="index_fix_final.php")

