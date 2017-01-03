apt-get install apt-transport-https ca-certificates &&  apt-key adv  --keyserver hkp://ha.pool.sks-keyservers.net:80  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main"  > /etc/apt/sources.list.d/docke.list
apt-get update && apt-get install docker-engine  -y
curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
chmod +x /usr/local/bin/docker-compose 
mkdir /opt/efk/ 
curl "https://gist.githubusercontent.com/asigatchov/417ac1dad9b57ae2ad25d62e87604f28/raw/8e85610f2a95a49f8d80260495a64c07ca56cad4/docker-compose-efk-16gb.yml" > /opt/efk/docker-compose.yml 
dd if=/dev/zero of=/swapfile bs=256M count=12 
chown root:root /swapfile 
chmod 0600 /swapfile 
mkswap /swapfile 
swapon /swapfile 
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh -
curl -L https://goo.gl/SMW2GO > /etc/td-agent/td-agent.conf
td-agent-gem install fluent-plugin-elasticsearch
echo 'server.host: "0.0.0.0"' > /opt/efk/kibana.yml
docker-compose -f /opt/efk/docker-compose.yml up -d
