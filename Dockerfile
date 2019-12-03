FROM store/intersystems/iris-community:2019.4.0.379.0

USER root

WORKDIR /opt/advent

RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} Installer.cls .
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} ./src ./src

ARG ADVENT_SESSION=

COPY irissession.sh /

SHELL [ "/irissession.sh" ]

RUN \
 do $system.OBJ.Load("/opt/advent/Installer.cls","ck") \
 set sc = ##class(Advent.Installer).setup(.vars, 3) \
 zn "ADVENT" \
 set ^AdventSession = $system.Util.GetEnviron("ADVENT_SESSION")

SHELL [ "/bin/sh", "-c" ]

RUN ls -la 