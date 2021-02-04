FROM  java:8-jre
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    #&& sed -i 's#http://deb.debian.org#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list \
    #&& sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 \
    && gpg --armor --export 648ACFD622F3D138 | apt-key add - \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517 \
    && gpg --armor --export DCC9EFBF77E11517 | apt-key add - \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC \
    && gpg --armor --export 04EE7237B7D453EC | apt-key add - \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 \
    && gpg --armor --export AA8E81B4331F7F50 | apt-key add - \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A \
    && gpg --armor --export 112695A0E562B32A | apt-key add - \
    && echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list 
    #&& echo "deb http://archive.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update --fix-missing -o Acquire::http::No-Cache=True && \
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