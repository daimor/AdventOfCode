FROM daimor/intersystems-cache:2017.2

WORKDIR /opt/advent

COPY src src

RUN ccontrol start $ISC_PACKAGE_INSTANCENAME quietly && \
    echo " do \$system.OBJ.ImportDir(\"/opt/advent/src/\",\"*.*\",\"ck\",,1)" \
         " halt" \
    | csession $ISC_PACKAGE_INSTANCENAME -UUSER && \
    ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly

VOLUME [ "/opt/advent" ]