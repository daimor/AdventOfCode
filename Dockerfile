FROM intersystems/iris:2018.2.0.490.0

WORKDIR /opt/advent

COPY Installer.cls .
COPY ./src ./src

ARG ADVENT_SESSION=

RUN iris start $ISC_PACKAGE_INSTANCENAME EmergencyId=admin,sys quietly && \
    /bin/echo -e "admin\nsys\n" \ 
                " do \$system.OBJ.Load(\"/opt/advent/Installer.cls\",\"ck\")" \
                " set vars(\"ADVENT_SESSION\")=\"${ADVENT_SESSION}\"\n" \
                " do ##class(Advent.Installer).setup(.vars, 3)" \
                " halt" \
    | iris session $ISC_PACKAGE_INSTANCENAME -UUSER && \
    iris stop $ISC_PACKAGE_INSTANCENAME quietly

VOLUME [ "/opt/advent" ]