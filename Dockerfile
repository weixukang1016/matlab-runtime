FROM  java:8-jre
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo "deb http://mirrors.ustc.edu.cn/debian/ buster main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.ustc.edu.cn/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.ustc.edu.cn/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.ustc.edu.cn/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update && \
	apt-get install -y xorg
RUN mkdir /mcr-install \
   && cd /mcr-install \
   && wget -O /mcr-install/MATLAB_Runtime.zip https://ssd.mathworks.com/supportfiles/downloads/R2019a/Release/9/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019a_Update_9_glnxa64.zip \
    && unzip MATLAB_Runtime.zip
# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin
# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
#默认安装路径为：/usr/local/MATLAB/MATLAB_Runtime
ENV MCR_ROOT       /usr/local/MATLAB/MATLAB_Runtime
ENV MCR_VERSION    2019a
ENV MCR_NUM        v96
# Install MatLab runtime
RUN cd /mcr-install \
    && ./install -mode silent -agreeToLicense yes -destinationFolder ${MCR_ROOT} \
    && cd / \
    && rm -rf /mcr-install
# Set MCR environment variables
ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
${MCR_ROOT}/${MCR_NUM}/runtime/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/bin/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/sys/os/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/sys/opengl/lib/glnxa64