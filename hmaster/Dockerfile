FROM firefoxx04/hbase-base:latest

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 16000 16010

# JMX Config
ARG rmi_addr
EXPOSE 9995
RUN echo "export HBASE_JMX_BASE=\"-Djava.rmi.server.hostname=${rmi_addr} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false\"" >> /etc/hbase/hbase-env.sh
RUN echo "export HBASE_MASTER_OPTS=\"\$HBASE_MASTER_OPTS \$HBASE_JMX_BASE -Dcom.sun.management.jmxremote.rmi.port=9995 -Dcom.sun.management.jmxremote.port=9995\"" >> /etc/hbase/hbase-env.sh

CMD ["/run.sh"]
