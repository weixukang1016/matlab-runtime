#swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52�����ذ�װ������ѹ��/mcr-install�����ز�������/mcr-install���docker
FROM swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52
RUN mkdir /mcr-install \
   && cd /mcr-install \
   && wget -O /mcr-install/MCR_R2017a_glnxa64_installer.zip https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip \
    && unzip MCR_R2017a_glnxa64_installer.zip
#���ز���װ������
RUN wget -O /mcr-install/MCR_R2017a_Update_3_glnxa64.sh https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_Update_3_glnxa64.sh