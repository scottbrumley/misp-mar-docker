# OpenDXL MISP McAfee Active Response "EDR" Integration
Docker container for the [OpenDXL MISP to MAR project](https://github.com/mohlcyber/MISP-MAR)

## How To Run

### Get DXL Project
  1.	SSH into docker01
  1.	Git clone project: git clone https://github.com/scottbrumley/dxl-webapi-docker.git
  1.	Change into Directory: cd dxl-webapi-docker

### Build  with ePO
  1.	./container.sh build
  1.	Edit Dockerfile for MISP API Key, MISP URL, and path to dxlclient.config

### Set DXL Permissions
  1.	Go to ePO  Server Settings  DXL Topic Authorization
  1.	Click Edit
  1.	Check TIE Server Enterprise Reputation
  1.	Click Actions
  1.	Choose Restrict Send Certificates
  1.	Choose your webapi client certificate (name should match the name in vars)
  1.	Click ok then save

### Run the Container
  1.	./container.sh run
  1.	Show Containers Running: sudo docker ps
  1.	Check containers logs: sudo docker opendxl_webapi

## Check via Docker
  - sudo docker ps "To search docker processes"
  - sudo docker logs misp-mar "To check the container logs"
