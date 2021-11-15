## Information
Need to set `loki_url` in pillar.

Also `promtailjobs` to add dedicated jobs per minion.
Example :
```
promtailjobs:
  - job: |
      - job_name: nginxaccess
        static_configs:
        - targets:
            - localhost
          labels:
            host: web
            job: nginxaccess
            __path__: /var/log/nginx/*.access.log
```
