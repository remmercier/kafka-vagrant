#!/bin/bash

sudo apt-get update

#########################################
#
#              CONFIGURATION
#
#########################################

#Timezone
sudo timedatectl set-timezone America/New_York

if [ ! -d "/vagrant/work" ]; then
  mkdir /vagrant/work
fi

#Kafka and zookeeper service
sudo mv /tmp/zk.service /etc/systemd/system/zk.service
sudo mv /tmp/kafka.service /etc/systemd/system/kafka.service
sudo mv /tmp/kafkamanager.service /etc/systemd/system/kafkamanager.service

sudo systemctl enable zk.service
sudo systemctl enable kafka.service
sudo systemctl enable kafkamanager.service

#########################################
#
#              SYSTEM TOOLS
#
#########################################

sudo apt-get install -y htop
sudo apt-get install -y ntp
sudo apt-get install -y unzip

# Java #
########
#auto accept license
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer

#########################################
#
#              APACHE KAFKA
#
#########################################

SCALA_VERSION=2.12
KAFKA_VERSION=0.10.2.0
KAFKA_MANAGER_VERSION=1.3.3.1

# Kafka server #
################
wget http://apache.forsale.plus/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
sudo tar zxvf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt
sudo mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka
sudo chown -R ubuntu:ubuntu /opt/kafka

# Kafka manager #
#################
#wget https://github.com/yahoo/kafka-manager/archive/${KAFKA_MANAGER_VERSION}.tar.gz
#tar zxvf ${KAFKA_MANAGER_VERSION}.tar.gz
#cd kafka-manager-${KAFKA_MANAGER_VERSION}
# Très long car le cache ivy2 doit être initialié
#./sbt clean dist
#sudo unzip target/universal/kafka-manager-${KAFKA_MANAGER_VERSION}.zip -d /opt
sudo unzip /tmp/kafka-manager-1.3.3.1.zip -d /opt
sudo mv /opt/kafka-manager-1.3.3.1 /opt/kafka-manager
sudo chown -R ubuntu:ubuntu /opt/kafka-manager

# Start zk, kafka and kafkamanager
sudo systemctl start zk.service
sudo systemctl start kafka.service
sudo systemctl start kafkamanager.service

