

```sh
oc process -f configmap.yaml -p LOGSTASH_ENDPOINT="logstash.logging.svc.cluster.local" | \
oc -n logging create -f -


oc -n logging create -f serviceaccount.yaml
oc -n logging adm policy add-scc-to-user privileged -z filebeat --as system:admin
oc -n logging create -f daemonset.yaml
```

