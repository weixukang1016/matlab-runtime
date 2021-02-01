FROM openjdk:8u181-jdk-alpine
# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin
# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
ENV MCR_VERSION    R2017a
ENV MCR_NUM        v92
# Install packages
RUN mkdir /mcr-install \
    && mkdir /opt \
    && mkdir /opt/mcr \
   && wget -O /mcr-install/MCR_R2017a_glnxa64_installer.zip https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip
# Install MatLab runtime
RUN cd /mcr-install \
    && unzip MCR_R2017a_glnxa64_installer.zip \
    && ./install -mode silent -agreeToLicense yes -destinationFolder /opt/mcr \
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
RUN wget -O /opt/mcr/MCR_R2017a_Update_3_glnxa64.sh https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_Update_3_glnxa64.sh
# Install MatLab runtime
RUN cd /opt/mcr \
    && chmod 777 MCR_R2017a_Update_3_glnxa64.sh \
    && ./MCR_R2017a_Update_3_glnxa64.sh -s \
    && rm -rf ./MCR_R2017a_Update_3_glnxa64.sh