FROM dockerfile/java:oracle-java8
MAINTAINER Guido Zockoll

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
    unzip glassfish-4.1.zip -d /opt && \
    rm glassfish-4.1.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish4/bin:$PATH

ADD run.sh /run.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh

VOLUME /opt/glassfish4/glassfish/domains/domain1/autodeploy

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 8181

CMD ["/run.sh"]
