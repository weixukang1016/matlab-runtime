#FROM openjdk:8u181-jdk-alpine
FROM java:8-jre

RUN mkdir /mcr-install \
   && cd /mcr-install \
   && wget -O /mcr-install/MCR_R2017a_glnxa64_installer.zip https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip \
    && unzip MCR_R2017a_glnxa64_installer.zip
#下载并安装补丁包
RUN wget -O /mcr-install/MCR_R2017a_Update_3_glnxa64.sh https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_Update_3_glnxa64.sh