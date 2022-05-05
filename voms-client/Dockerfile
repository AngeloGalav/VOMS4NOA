FROM centos:7

# installa alcuni dei pacchetti necessari
RUN yum install -y epel-release wget

# aggiunge il nuovo utente in modo non interattivo
RUN useradd -ms /bin/bash test

# installazione di voms-clients-java per fare voms-proxy-init
RUN yum install -y  voms-clients-java

# scarica e installa 
RUN wget https://ci.cloud.cnaf.infn.it/view/repos/job/repo_test_ca/lastSuccessfulBuild/artifact/test-ca.repo -O /etc/yum.repos.d/test-ca.repo && yum install -y igi-test-ca

# crea la cartella globus e copiaci i certificati 
RUN mkdir -p /home/test/.globus && cp /usr/share/igi-test-ca/test0.p12 /home/test/.globus/usercred.p12 && \
    chmod 600 /home/test/.globus/usercred.p12 && \
    chown -R test:test /home/test/.globus


# zona dove sta la catena delle CA
RUN mkdir -p "/etc/grid-security/vomsdir/test.vo"
WORKDIR "/etc/grid-security/vomsdir/test.vo/"
RUN wget https://raw.githubusercontent.com/italiangrid/storm-webdav/authomatize-ts/compose/assets/vomsdir/test.vo/vgrid02.cnaf.infn.it.lsc

# zona di test.vo
RUN mkdir -p "/etc/vomses"
WORKDIR /etc/vomses
RUN wget https://raw.githubusercontent.com/italiangrid/storm-webdav/authomatize-ts/compose/assets/vomses/test.vo

# repofile per CA GRID
WORKDIR /etc/yum.repos.d/
RUN wget https://raw.githubusercontent.com/indigo-iam/egi-trust-anchors-container/main/EGI-trustanchors.repo

# installazione della CA grid in '/etc/grid-security/certificates'
RUN yum install -y ca-policy-egi-core

WORKDIR /home/test

# cambia a user test
USER test

# voms-proxy-init -pwstdin -voms test.vo <<< pass




