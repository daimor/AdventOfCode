FROM intersystems/iris:2018.2.0.490.0

WORKDIR /opt/advent

COPY src src

RUN echo SYS > /tmp/password && changePassword.sh /tmp/password \
 && iris start $ISC_PACKAGE_INSTANCENAME quietly && \
    /bin/echo -e "_SYSTEM\nSYS\n" \
                " do \$system.OBJ.ImportDir(\"/opt/advent/src/\",\"*.*\",\"ck\",,1)" \
                " halt" \
    | iris session $ISC_PACKAGE_INSTANCENAME -UUSER && \
    iris stop $ISC_PACKAGE_INSTANCENAME quietly

VOLUME [ "/opt/advent" ]