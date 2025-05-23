ARG IMAGE=intersystemsdc/irishealth-community:latest
FROM $IMAGE as builder
USER ${ISC_PACKAGE_MGRUSER}


WORKDIR /opt/FHIRReportGeneration


COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} iris.script iris.script
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} src src
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} resource resource

RUN python3 -m pip install --target /usr/irissys/mgr/python  requests -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn




RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly

