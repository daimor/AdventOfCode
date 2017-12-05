FROM daimor/intersystems-cache:2017.2

WORKDIR /opt/advent

ARG CACHE_KEY

COPY src src

RUN echo -e "${CACHE_KEY}" > /opt/cache/mgr/cache.key

RUN ccontrol start $ISC_PACKAGE_INSTANCENAME quietly && \
    echo " do \$system.OBJ.ImportDir(\"/opt/advent/\",\"*.*\",\"ck\",,1)" \
         " do ##class(%Studio.SourceControl.Interface).SourceControlClassSet(\"SourceControl.File\")" \
         " set ^Sources=\"/opt/advent/src/\"" \
         " set ^Sources(\"MAC\",\"*\")=\"2017/\"" \
         " set ^Sources(\"CLS\",\"*\")=\"\"" \
         " halt" \
    | csession $ISC_PACKAGE_INSTANCENAME -UUSER && \
    ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly

VOLUME [ "/opt/advent" ]