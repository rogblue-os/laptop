# laptop
Modified Silverblue image for Asus ROG laptops.

# Usage
- Install Fedora Silverblue 37
- Rebase to this image:
    - sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/rogblue-os/laptop:latest

# Included
- Fedora flatpaks and filtered flathub repo are removed
- All flatpaks are installed with --user flag and not as system
- Includes base Gnome apps installed from Flathub and not Fedoras own flatpak repo
- asusctl, supergfxctl and asusctl-rog-gui from [Asus-linux.org](www.asus-linux.org) are included and supergfxctl also started on boot
