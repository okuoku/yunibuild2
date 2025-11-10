FROM fedora:rawhide
RUN dnf upgrade -y && dnf install -y cmake gcc g++ clang ninja-build wayland-devel libXext-devel mesa-libgbm-devel mesa-libEGL-devel libdrm-devel libxkbcommon-devel libunwind-devel pulseaudio-libs-devel
ENV YUNIBUILD_LOCAL_TYPE=Linux
ENV YUNIBUILD_LOCAL_VARIANT=Fedora
