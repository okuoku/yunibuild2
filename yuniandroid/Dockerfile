# Phase1: opt-extract
FROM ubuntu:latest as opt-extract
RUN apt update && apt upgrade -y && apt install -y unzip
ADD https://services.gradle.org/distributions/gradle-9.2.0-all.zip /
RUN unzip /gradle-9.2.0-all.zip
RUN cp -rp /gradle-9.2.0 /opt
RUN mv /opt/gradle-9.2.0 /opt/gradle

ADD https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip /
# COPY commandlinetools-linux-13114758_latest.zip /
RUN unzip /commandlinetools-linux-13114758_latest.zip
RUN mkdir -p /opt/android/cmdline-tools
RUN cp -rp /cmdline-tools /opt/android/cmdline-tools/latest

# Phase2
FROM --platform=linux/amd64 ubuntu:latest
COPY --from=opt-extract /opt /opt
# cmake ninja-build are only for script running
RUN apt update && apt upgrade -y && apt install -y default-jdk cmake ninja-build
ENV JAVA_HOME=/usr
RUN yes | /opt/android/cmdline-tools/latest/bin/sdkmanager --licenses
RUN /opt/android/cmdline-tools/latest/bin/sdkmanager --install \
  "ndk;29.0.14206865" "platform-tools" "cmake;3.31.6" \
  "extras;google;google_play_services" "platforms;android-36"
ENV ANDROID_HOME=/opt/android
ENV GRADLE_HOME=/opt/gradle
ENV YUNIBUILD_IMAGE_TYPE=yuniandroid
