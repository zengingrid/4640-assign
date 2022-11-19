Refresher
Installing Terraform (via binary)
1. Visit https://developer.hashicorp.com/terraform/downloads
2. Binary download for Linux: AMD64 
3. Unzip the folder and move the file into usr/local/bin
4. Remove the zip
  
Assignment
Reusing the wk6 directory with the subdirectory: /dev
- Creating the .env file
  1. In digitalocean, go to API to generate a token
  2. copy the token and put it in a .env file
  3. export the token as TF_VAR (export TF_VAR_do_token)
  4. source .env
- To breakout terraform files for easier configuration update: 
  - main.tf: provider info
  - variables.tf: reusable varialbes (to avoid hard-coding values)
  - terraform.tfvars: variable values
  - data.tf: data blocks
  - network.tf: vpc
  - servers.tf: droplets, load balancer, and firewall for servers (NEW)
  - output.tf: any output values, like ip addresses and database connection uri
  - database.tf (NEW): database cluster and firewall
  - bastion.tf (NEW): server, attachment, and firewall
   
  - To run: 
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
    SUCCESS:
    ![image](https://user-images.githubusercontent.com/71790092/202872253-64b3d904-6521-43cb-a126-4bfb8128bc50.png)
  - To delete everything (after finishing the project)
    ```bash
    terraform destroy
    ``` 
Testing
- Test bastion server's connection to internal servers
  - eval $(ssh-agent)
  - In localhost: ssh-add <path to private key>
  - In localhost: ssh -A root@<publicIP_bastion_server>
  ![image](https://user-images.githubusercontent.com/71790092/202872342-b932c0d3-a9d0-4bb7-922c-f262d9bd5880.png)
  - In Bastion: ssh -A root@<internalIP_web_server_1>
  ![image](https://user-images.githubusercontent.com/71790092/202872363-eebf407d-b961-4837-97d7-24c36d9e9fb5.png)
- Test connection to MySQL database
  - Find database cluster info on digitalocean
  - Add local computer to the database’s trusted sources
  ![image](https://user-images.githubusercontent.com/71790092/202872374-39fb4c7a-4741-444a-b68c-958752764579.png)
  - Copy the command to CLI
  ![image](https://user-images.githubusercontent.com/71790092/202873303-2f4127dd-4aea-4094-ba13-444828a9264e.png)

  
  

