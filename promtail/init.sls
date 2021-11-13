promtail:
  user.present:
    - fullname: Grafana promtail
    - shell: /usr/sbin/nologin
    - home: /opt/promtail

promtail_conf:
  file.managed:
    - name: /opt/promtail/promtail-config.yml
    - source: salt://promtail/templates/promtail-config.j2
    - template: jinja
    - user: promtail
    - group: promtail
    - mode: '0644'


promtail_binary:
  archive.extracted:
    - name: /usr/local/bin
    - source: https://github.com/grafana/loki/releases/download/v2.4.1/promtail-linux-amd64.zip
    - source_hash: 86615266adb18874dc05fea96ecb1e76849002dc
    - user: promtail
    - group: promtail
    - enforce_toplevel: False

promtail_systemd_unit:
  file.managed:
    - name: /etc/systemd/system/promtail.service
    - source: salt://promtail/files/promtail.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: promtail_systemd_unit

promtail_running:
  service.running:
    - name: promtail
    - enable: True
    - watch:
      - module: promtail_systemd_unit
