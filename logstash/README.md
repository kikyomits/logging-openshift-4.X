
```sh
oc new-project logging
oc create -f build.yaml
oc start-build logstash --from-dir=./docker-logstash
```



```sh
export SUMO_ENDPOINT="https://collectors.jp.sumologic.com/receiver/v1/http/ZaVnC4dhaV0..."
oc process -f openshift/configmap.yaml -p SUMO_ENDPOINT=$SUMO_ENDPOINT | oc create -f -
oc create -f deploy.yaml
```