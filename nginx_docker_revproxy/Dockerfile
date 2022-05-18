FROM baltig.infn.it:4567/storm2/ngx_http_voms_module/openresty-voms:openresty-with-njs-latest

COPY nginx_docker_revproxy/config_files/vgrid02.cnaf.infn.it.lsc /etc/grid-security/vomsdir/test.vo/vgrid02.cnaf.infn.it.lsc

COPY nginx_docker_revproxy/config_files/EGI-trustanchors.repo /etc/yum.repos.d/EGI-trustanchors.repo

RUN yum -y install ca-policy-egi-core