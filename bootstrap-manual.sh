#! /bin/bash 
#set -x

#apk update
#apk add curl

#wupiaowt() {
#    # [w]ait [u]ntil [p]ort [i]s [a]ctually [o]pen [w]ith [t]imeout <who> <timeout> <target>
#    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
#        echo 'Invalid parameters'
#        exit 1
#    fi
#    if ! timeout -t $2 -s KILL /bin/sh -c "until curl -XGET -o /dev/null -sf 'http://$3'; do sleep 1s && echo '$1 waiting for $3 ...'; done"; then
#        echo "$0 timeout: $3 was unreachable"
#        exit 137
#    fi
#}

#wupiaowt "$0" 70 "localhost:3000"

#wupiaowt "$0" 70 "influxdb:8086"


curl -i -XPOST 'http://localhost:8086/query?q=CREATE+DATABASE+%22telegraf%22&db=_internal' 

curl -i -XPOST 'http://localhost:8086/query?q=CREATE+DATABASE+%22perfana_trends%22&db=_internal'


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/datasources' \
                  --header 'Content-Type: application/json' \
                  --data-binary "{\"name\":\"Graphite\",\"type\":\"graphite\",\"url\":\"http://graphite\",\"access\":\"proxy\",\"jsonData\":{\"graphiteVersion\":\"1.0\"},\"secureJsonFields\":{}}"


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/datasources' \
                  --header 'Content-Type: application/json' \
                  --data-binary "{\"name\":\"influxdb telegraf\",\"type\":\"influxdb\",\"access\":\"proxy\",\"url\":\"http://influxdb:8086\",\"password\":\"foobar\",\"user\":\"foobar\",\"database\":\"telegraf\",\"basicAuth\":false,\"isDefault\":true}"


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/datasources' \
                  --header 'Content-Type: application/json' \
                  --data-binary "{\"name\":\"influxdb perfana trends\",\"type\":\"influxdb\",\"access\":\"proxy\",\"url\":\"http://influxdb:8086\",\"password\":\"foobar\",\"user\":\"foobar\",\"database\":\"perfana_trends\",\"basicAuth\":false,\"isDefault\":true}"


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/datasources' \
                  --header 'Content-Type: application/json' \
                  --data-binary "{\"name\":\"influxdb gatling\",\"type\":\"influxdb\",\"access\":\"proxy\",\"url\":\"http://influxdb:8086\",\"password\":\"foobar\",\"user\":\"foobar\",\"database\":\"gatling\",\"basicAuth\":false,\"isDefault\":true}"


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/datasources' \
                  --header 'Content-Type: application/json' \
                  --data-binary "{\"name\":\"Prometheus\",\"type\":\"prometheus\",\"access\":\"proxy\",\"url\":\"http://prometheus:9090\",\"password\":\"foobar\",\"user\":\"foobar\",\"basicAuth\":false}"


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/dashboards/import' \
                  --header 'Content-Type: application/json' \
                  --data-binary @./gatling.json



curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/dashboards/import' \
                  --header 'Content-Type: application/json' \
                  --data-binary @./system.json


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/dashboards/import' \
                  --header 'Content-Type: application/json' \
                  --data-binary @./prometheus-docker-dashboard.json


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/dashboards/import' \
                  --header 'Content-Type: application/json' \
                  --data-binary @./graphite.json


curl -i -XPOST 'http://foobar:foobar@localhost:3000/api/dashboards/import' \
                  --header 'Content-Type: application/json' \
                  --data-binary @./perfana_trends.json



