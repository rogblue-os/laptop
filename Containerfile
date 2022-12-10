FROM ghcr.io/rogblue-os/base:latest
# See https://pagure.io/releng/issue/11047 for final location

# Add asus-kernel repo for future use
RUN  cd /etc/yum.repos.d/ && sudo wget https://copr.fedorainfracloud.org/coprs/lukenukem/asus-kernel/repo/fedora-37/lukenukem-asus-kernel-fedora-37.repo

RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-37/lukenukem-asus-linux-fedora-37.repo && \
    rpm-ostree install gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock asusctl supergfxctl asusctl-rog-gui && \
    systemctl enable supergfxd && \
    rpm-ostree cleanup -m  && \
	ostree container commit
