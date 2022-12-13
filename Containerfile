FROM ghcr.io/rogblue-os/base:latest
# See https://pagure.io/releng/issue/11047 for final location

# Add asus-kernel repo for future use
RUN  cd /etc/yum.repos.d/ && sudo wget https://copr.fedorainfracloud.org/coprs/lukenukem/asus-kernel/repo/fedora-37/lukenukem-asus-kernel-fedora-37.repo

# Asus-Linux kernel
RUN rpm-ostree cliwrap install-to-root /
RUN sudo rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:lukenukem:asus-kernel kernel kernel-core kernel-modules kernel-modules-extra

# Temp fix to make the kernel build bootable
#RUN /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver 6.0.11-308.rog.fc37.x86_64 --reproducible \
#    -v --add ostree -f /tmp/initramfs2.img
#RUN mv /tmp/initramfs2.img /lib/modules/6.0.11-308.rog.fc37.x86_64/initramfs.img

RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-37/lukenukem-asus-linux-fedora-37.repo && \
    rpm-ostree install gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock asusctl supergfxctl asusctl-rog-gui && \
    systemctl enable supergfxd && \
    rpm-ostree cleanup -m  && \
	ostree container commit
