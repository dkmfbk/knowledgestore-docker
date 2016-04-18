############################################################
# Dockerfile to run KnowledgeStore 1.8 Containers
# Based on Centos / RedHat Image
############################################################

# Set the base image to use to Ubuntu
FROM centos:7.2.1511

RUN yum -y update && yum clean all && yum -y install autoconf automake libtool flex bison gperf git openssl-devel readline-devel wget java-1.8.0-openjdk.x86_64 python-setuptools initscripts openssh openssh-server openssh-clients sudo passwd sed screen tmux byobu which vim-enhanced

#setting sshd
RUN sshd-keygen && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

#set root passord
RUN echo 'root:password' | chpasswd

#add additional user
#RUN groupadd ksusers && useradd ks -g ksusers -s /bin/bash -m && echo 'ks:password' | chpasswd

#install supervisor
ADD supervisord.conf /etc/supervisord.conf
RUN easy_install supervisor

#create folders for virtuoso and ks
RUN mkdir /data && mkdir /data/software 

VOLUME /data/instances /data/scripts /data/additional_data


#Download KS software
RUN cd /data/software  && wget "http://knowledgestore.fbk.eu/files/vm/ks-software.tar.gz" && \
tar --no-same-owner -xvzf ks-software.tar.gz && \
rm -f ks-software.tar.gz

##binaries of virtuoso are in /data/software/virtuoso/bin
#RUN cd /data/software  && wget "http://knowledgestore.fbk.eu/files/vm/virtuoso-7.2.0.1.tar.gz" && \
#tar --no-same-owner -xvzf virtuoso-7.2.0.1.tar.gz && \
#rm -f virtuoso-7.2.0.1.tar.gz && \
#mv 7.2.0.1 virtuoso
#
##binaries of ks are in /data/software/knowledgestore/bin
#RUN cd /data/software  && wget "http://knowledgestore.fbk.eu/files/vm/ks-1.8.tar.gz" && \
#tar --no-same-owner -xvzf ks-1.8.tar.gz && \
#rm -f ks-1.8.tar.gz
#
##binaries of rdfpro are in /data/software/rdfpro
#RUN cd /data/software  && wget "http://knowledgestore.fbk.eu/files/vm/rdfpro-0.5.1.tar.gz" && \
#tar --no-same-owner -xvzf rdfpro-0.5.1.tar.gz && \
#rm -f rdfpro-0.5.1.tar.gz
#
##binaries of newsreader-tools are in /data/software/newsreader-tools
#RUN cd /data/software  && wget "http://knowledgestore.fbk.eu/files/vm/newsreader-tools-1.0.tar.gz" && \
#tar --no-same-owner -xvzf newsreader-tools-1.0.tar.gz && \
#rm -f newsreader-tools-1.0.tar.gz

# Expose ports.
#   - 9051: Virtuoso
#   - 9053: KS UI
#   - 22: ssh
EXPOSE 22 9051 9053


#extend PATH
RUN echo "PATH=$PATH:/data/software/virtuoso/bin:/data/software/knowledgestore/bin:/data/software/rdfpro:/data/software/newsreader-tools:/data/scripts" >> /root/.bash_profile
RUN echo "export PATH" >> /root/.bash_profile

CMD ["/usr/bin/supervisord"]
