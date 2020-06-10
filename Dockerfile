FROM ubuntu:18.04 as builder

# RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && apt-get install -qy pwgen

RUN mkdir -p /overlay
WORKDIR /overlay

RUN mkdir -p bin etc etc/service dev dev/pts lib proc sys tmp var var/lib var/run var/log \
  usr usr/sbin usr/bin usr/lib root

RUN chmod a+w tmp &&\
  touch etc/resolv.conf &&\
  cp /etc/nsswitch.conf etc/nsswitch.conf &&\
  echo root:x:0:0:root:/root:/bin/sh > etc/passwd &&\
  echo root:x:0: > etc/group &&\
  echo spk:x:1000:1000::/home/spk:/bin/nologin >> etc/passwd &&\
  echo spk:x:1000: >> etc/group &&\
  echo spk:x:1000:1000::/home/spk:/bin/nologin >> /etc/passwd &&\
  echo spk:x:1000: >> /etc/group

RUN ln -s lib lib64 &&\
  ln -s bin sbin &&\
  bash -c "cp /lib/x86_64-linux-gnu/lib{c,m,dl,rt,nsl,nss_*,pthread,resolv,gcc*}.so.* lib" &&\
  cp -a /root /overlay/ &&\
  mkdir -p /overlay/home/spk &&\
  chown -R spk:spk home/spk

RUN cp /usr/sbin/nologin usr/bin/ &&\
  cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib/ &&\
  cp /lib/x86_64-linux-gnu/libtinfo.so.5 lib/ &&\
  cp /lib/x86_64-linux-gnu/libutil.so.1 lib/ &&\
  cp /lib/x86_64-linux-gnu/libz.so.1 lib/

RUN echo "/lib/x86_64-linux-gnu" && ls -al /lib/x86_64-linux-gnu

FROM scratch

COPY --from=builder /overlay /

WORKDIR /home/spk

CMD ["/usr/bin/nologin"]
