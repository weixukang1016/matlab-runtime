#swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52是下载安装包并解压到/mcr-install和下载补丁包到/mcr-install后的docker
FROM swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52
RUN mkdir /mcr-install \
   && cd /mcr-install \
   && wget -O /mcr-install/MCR_R2017a_glnxa64_installer.zip https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip \
    && unzip MCR_R2017a_glnxa64_installer.zip
#下载并安装补丁包
RUN wget -O /mcr-install/MCR_R2017a_Update_3_glnxa64.sh https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_Update_3_glnxa64.sh