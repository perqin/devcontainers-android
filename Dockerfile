FROM mcr.microsoft.com/devcontainers/java:21

# e.g. 36.1.0
ARG BUILD_TOOLS_VERSION
# e.g. 36
ARG PLATFORM_VERSION

RUN curl https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -o /tmp/cmdline-tools.zip \
    && unzip -d /tmp /tmp/cmdline-tools.zip \
    && mkdir -p /opt/android-sdk/cmdline-tools \
    && mv /tmp/cmdline-tools /opt/android-sdk/cmdline-tools/latest

ENV ANDROID_HOME="/opt/android-sdk"
ENV ANDROID_SDK_ROOT="$ANDROID_HOME"
ENV PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/build-tools/${BUILD_TOOLS_VERSION}:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

RUN yes | sdkmanager --licenses \
    && sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${PLATFORM_VERSION}"
