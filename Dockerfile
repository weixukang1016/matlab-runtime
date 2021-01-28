FROM java:8-jre

# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin

# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
ENV MCR_VERSION    R2017a
ENV MCR_NUM        v92

# Install packages
# RUN apt-get update && apt-get install -y \
# RUN wget https://ssd.mathworks.com/supportfiles/downloads/R2015b/deployment_files/R2015b/installers/glnxa64/MCR_R2015b_glnxa64_installer.zip \
#RUN wget https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip \
#    unzip MCR_R2017a_glnxa64_installer.zip \
#RUN wget \
#    unzip \
#    xorg \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*

RUN wget https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip

# Add MCR intall files
#ADD MCR_${MCR_VERSION}.zip /mcr-install/mcr.zip
ADD MCR_R2017a_glnxa64_installer.zip /mcr-install
ADD mcr-config.txt /mcr-install/mcr-config.txt

# Install MatLab runtime
RUN cd /mcr-install \
#    && unzip mcr.zip \
    && mkdir /opt/mcr \
    && ./install -inputFile mcr-config.txt \
    && cd / \
    && rm -rf /mcr-install

# Set MCR environment variables
ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
/opt/mcr/${MCR_NUM}/runtime/glnxa64:\
/opt/mcr/${MCR_NUM}/bin/glnxa64:\
/opt/mcr/${MCR_NUM}/sys/os/glnxa64:

ENV XAPPLRESDIR        /opt/mcr/${MCR_NUM}/X11/app-defaults

# Define default command
CMD ["bash"]
