#!/bin/bash -e

### Start Logstash
exec ${LS_HOME}/bin/logstash -f ${LS_CONFIG_PATH} --log.level=error
