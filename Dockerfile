#FROM java:8-jre
FROM swr.cn-north-4.myhuaweicloud.com/pvsoul/eec-center:1
# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin
# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
ENV MCR_VERSION    R2017a
ENV MCR_NUM        v92
# Install packages
RUN mkdir /mcr-install \
   && wget -O /mcr-install/MCR_R2017a_glnxa64_installer.zip https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip
# Install MatLab runtime
RUN cd /mcr-install \
    && unzip MCR_R2017a_glnxa64_installer.zip \
    && mkdir /opt/mcr \
    && ./install -mode silent -agreeToLicense yes \
    && cd / \
    && rm -rf /mcr-install
# Set MCR environment variables
ENV XAPPLRESDIR        MCR_ROOT/v92/X11/app-defaults
ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
/opt/mcr/v92/runtime/glnxa64:\
/opt/mcr/v92/bin/glnxa64:\
/opt/mcr/v92/sys/os/glnxa64:\
/opt/mcr/v92/sys/opengl/lib/glnxa64
#下载并安装补丁包
RUN mkdir /mcr-update \
   && wget -O /opt/mcr/MCR_R2017a_Update_3_glnxa64.sh https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_Update_3_glnxa64.sh
# Install MatLab runtime
RUN cd /opt/mcr \
    && ./MCR_R2017a_Update_3_glnxa64.sh -mode silent -agreeToLicense yes \
#    && cd / \
    && rm -rf ./MCR_R2017a_Update_3_glnxa64.sh