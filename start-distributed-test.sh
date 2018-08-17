#! /bin/sh

#First argument is a list of IPs
#Second agrument is a command to run gatling test

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 1;
fi 

if [[ -n $1 ]]; then
    ips=$(echo $1 | tr "," "\n")
    for ip in $ips
    do
        echo "Start command: ssh -o StrictHostKeyChecking=no -i ${WORKSPACE}/terraform-scripts/jmeter-servers/ssh-key/id_rsa_terraform ec2-user@$ip "$2" &"
        sudo ssh -o StrictHostKeyChecking=no -i ${WORKSPACE}/terraform-scripts/gatling-node/ssh-key/id_rsa_terraform ec2-user@$ip "$2" &
    done
    wait
else
    echo "First arguments must be spesified. Example: 127.0.0.0,127.0.0.1"
    exit 1;
fi
