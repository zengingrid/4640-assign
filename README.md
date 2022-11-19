Assignment

<h2>Refresher</h2>
- Installing Terraform (via binary)
  1. Visit https://developer.hashicorp.com/terraform/downloads
  2. Binary download for Linux: AMD64 
  3. Unzip the folder and move the file into usr/local/bin
  4. Remove the zip
  
<h2>Reusing the wk6 directory with the subdirectory: /dev</h2>
- In /dev
  - Creating the .env file
      1. In digitalocean, go to API to generate a token
      2. copy the token and put it in a .env file
      3. export the token as TF_VAR (export TF_VAR_do_token)
      4. source .env
  - To breakout terraform files for easier configuration update: 
    - main.tf: provider info
    - variables.tf: reusable varialbes (to avoid hard-coding values)
    - terraform.tfvars: variable values
    - output.tf: any output values, like ip addresses and database connection uri
    - database.tf (NEW): database cluster and firewall
    - servers.tf: droplets, load balancer, and firewall for servers (NEW)
    - bastion.tf (NEW): server, attachment, and firewall
    - network.tf: vpc
    - data.tf: data blocks (ssh keys)   
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
    ![image](https://user-images.githubusercontent.com/71790092/202868413-9dca5449-1ce2-45f1-bab9-d2481e0b121c.png)
  - To delete everything (after finishing the project)
    ```bash
    terraform destroy
    ``` 
<h2>Testing</h2>
- Test bastion server's connection to internal servers
  - ssh-add <path to private key>
  ![image](https://user-images.githubusercontent.com/71790092/202869002-fdda4d0e-94e8-45da-ab7d-15a1b90ddc94.png)
  - ssh -A root@<public IP of bastion server>
  ![image](https://user-images.githubusercontent.com/71790092/202869047-9e309eab-4fb2-4934-bad4-ae339535059d.png)
  - ssh -A root@<internal IP of web server 1>
  ![image](https://user-images.githubusercontent.com/71790092/202869069-b6bcd84b-965a-493e-a960-531d8d4736ae.png)
- Test web servers' connection to MySQL database
- Test web server's connection to Load Balancer

