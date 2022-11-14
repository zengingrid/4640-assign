Lab 6: Terraform

Refresher
- Installing Terraform (via binary)
  1. Visit https://developer.hashicorp.com/terraform/downloads
  2. Binary download for Linux: AMD64 
  3. Unzip the folder and move the file into usr/local/bin
  4. Remove the zip
  
Create a wk6 directory with two subdirectories: /dev and /mgmt
- In /dev
  - Creating the .env file
      1. In digitalocean, go to API to generate a token
      2. copy the token and put it in a .env file
      3. export the token as TF_VAR (export TF_VAR_do_token)
      4. source .env
  - Creating variable.tf to specify variables (e.g. region, token etc) used in main.tf  
  - Creating main.tf based on digital ocean documentation (based on lab5 but with a lb)
  - Creating terraform.tfvars to save state
  - Run: 
    ```bash
    terraform init
    ```
  - To validate
     ```bash
    terraform plan or terraform validate
    ``` 
  - To build
     ```bash
    terraform apply
    ``` 
  - To delete everything (after finishing the project)
     ```bash
    terraform destroy
    ``` 
- In /mgmt
  - Copying reusable files from 4640-pod1 labs
    1. ansible.cfg file
    2. inventory directory
    3. private key file
    4. do_token file (remember to source it in wsl)
  - Creating a nginx_setup.yml file to install and enable Nginx
  - Checking the grouped droplets
    ```
    ansible-inventory --graph
    ```
  - Installing Nginx on the 3 droplets
    ```
    ansible-playbook nginx_setup.yml -u root --private-key digocean.pem
    ```
- In digitalocean
  - On left menu, go to Networking
  - Find the Load Balancers tab
  - Copy the IP address of the load balancer
  - Visit 
 ![image](https://user-images.githubusercontent.com/71790092/200472733-7b6ac47f-59fe-40d5-99a4-a95c83732d7b.png)

