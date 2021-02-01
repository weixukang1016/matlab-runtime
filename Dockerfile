#swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52是下载安装包并解压到/mcr-install和下载补丁包到/mcr-install后的docker
FROM swr.cn-north-4.myhuaweicloud.com/pvsoul/matlab-runtime:v1.0.52
# Set Java environment variables
ENV JAVA_HOME      /usr/bin/java
ENV PATH           ${PATH}:${JAVA_HOME}/bin
# Set MCR environment variables
ENV MATLAB_JAVA    ${JAVA_HOME}
ENV MCR_ROOT       /usr/local/MATLAB/MATLAB_Runtime
ENV MCR_VERSION    R2017a
ENV MCR_NUM        v92
#默认安装路径为：/usr/local/MATLAB/MATLAB_Runtime
# Install MatLab runtime
RUN cd /mcr-install \
    && ./install -mode silent -agreeToLicense yes -destinationFolder ${MCR_ROOT} \
# Set MCR environment variables
ENV XAPPLRESDIR        ${MCR_ROOT}/${MCR_NUM}/X11/app-defaults
ENV LD_LIBRARY_PATH    ${LD_LIBRARY_PATH}:\
${MCR_ROOT}/${MCR_NUM}/runtime/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/bin/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/sys/os/glnxa64:\
${MCR_ROOT}/${MCR_NUM}/sys/opengl/lib/glnxa64
# 安装补丁包
RUN chmod 777 MCR_R2017a_Update_3_glnxa64.sh \
    && ./MCR_R2017a_Update_3_glnxa64.sh -s
#删除下载的文件
RUN cd / \
    && rm -rf /mcr-install