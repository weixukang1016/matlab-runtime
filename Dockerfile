FROM centos:latest
#RUN apt-get update && \
#	apt-get install -y xorg

RUN mkdir /opt/jdk \
   && mkdir /usr/java 
RUN wget -O /usr/java/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
#RUN copy /usr/java/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz /opt/jdk/ && rm -rf /opt/jdk/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz \
#    && tar -zxf /opt/jdk/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz -C /opt/jdk/ && rm -rf /opt/jdk/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
ADD /usr/java/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz  /opt/java/
RUN rm -rf /usr/java 
ENV JAVA_HOME=/opt/jdk/java-se-8u41-ri/
ENV PATH=$PATH:$JAVA_HOME/bin
RUN cd /opt/jdk \
 && ls
RUN java -version


#安装matlab-runtime
RUN mkdir /mcr-install \
   && cd /mcr-install \
   && wget -O /mcr-install/MATLAB_Runtime.zip https://ssd.mathworks.com/supportfiles/downloads/R2019a/Release/9/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019a_Update_9_glnxa64.zip \
    && unzip MATLAB_Runtime.zip
# Set Java environment variables
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