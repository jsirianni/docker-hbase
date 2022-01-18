FROM firefoxx04/hbase-base:latest

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 16020 16030

# JMX Config
ARG rmi_addr
EXPOSE 9996
RUN echo "export HBASE_JMX_BASE=\"-Djava.rmi.server.hostname=${rmi_addr} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false\"" >> /etc/hbase/hbase-env.sh
RUN echo "export HBASE_REGIONSERVER_OPTS=\"\$HBASE_REGIONSERVER_OPTS \$HBASE_JMX_BASE -Dcom.sun.management.jmxremote.rmi.port=9996 -Dcom.sun.management.jmxremote.port=9996\"" >> /etc/hbase/hbase-env.sh

CMD ["/run.sh"]
