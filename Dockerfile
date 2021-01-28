FROM java:8-jre

# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin

# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
ENV MCR_VERSION    R2017a
ENV MCR_NUM        v92

# Install packages
RUN https://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip

# Add MCR intall files
ADD MCR_R2017a_glnxa64_installer.zip /mcr-install
ADD mcr-config.txt /mcr-install/mcr-config.txt

# Install MatLab runtime
RUN cd /mcr-install \
    && mkdir /opt/mcr \
    && ./install -inputFile mcr-config.txt \
    && cd / \
    && rm -rf /mcr-install


# Set MCR environment variables
ENV XAPPLRESDIR        MCR_ROOT/v92/X11/app-defaults

ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
/opt/mcr/v92/runtime/glnxa64:\
/opt/mcr/v92/bin/glnxa64:\
/opt/mcr/v92/sys/os/glnxa64:\
/opt/mcr/v92/sys/opengl/lib/glnxa64

# Define default command
CMD ["bash"]
