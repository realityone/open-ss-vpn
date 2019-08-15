FROM ubuntu:16.04

ENV SHADOWSOCKS_VERSION v1.7.2-alpha.19

RUN apt update && \
    apt install -y openvpn iproute2 wget curl iptables iputils* net-tools xz-utils supervisor && \
    echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf && \
    wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_VERSION}/shadowsocks-${SHADOWSOCKS_VERSION}-stable.x86_64-unknown-linux-musl.tar.xz -O /opt/shadowsocks.tar.xz && \
    cd /opt/ && \
    xz -d ./shadowsocks.tar.xz && \
    tar xf ./shadowsocks.tar && \
    cd / && \
    rm -rf /var/lib/apt/lists/*

VOLUME /vpnlocation

ENV VPN_LOCATION=09-USA-Fremont-2
CMD ["/entrypoint.sh"]

ADD ./supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD ./entrypoint.sh /entrypoint.sh
