FROM ghcr.io/rogblue-os/base:latest
# See https://pagure.io/releng/issue/11047 for final location

# Add asus-kernel repo (will propably remove this when kernel 6.1 hits SB stable)
RUN  cd /etc/yum.repos.d/ && sudo wget https://copr.fedorainfracloud.org/coprs/lukenukem/asus-kernel/repo/fedora-37/lukenukem-asus-kernel-fedora-37.repo

# Add asus-linux tools repo (asusctl, supergfxctl and asusctl-rog-gui)
RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-37/lukenukem-asus-linux-fedora-37.repo

# Install asus-Linux kernel
RUN rpm-ostree cliwrap install-to-root /
RUN sudo rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:lukenukem:asus-kernel kernel kernel-core kernel-modules kernel-modules-extra

RUN rpm-ostree install gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock asusctl supergfxctl asusctl-rog-gui && \
    systemctl enable supergfxd && \
    rpm-ostree cleanup -m  && \
    ostree container commit
