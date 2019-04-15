FROM ruby:slim

# install dependencies
RUN apt-get update && apt-get install -y \
	git \
	gconf2 \
	gconf-service \
	gvfs-bin \
	libasound2 \
	libcap2 \
	libgconf-2-4 \
	libgnome-keyring-dev \
	libgtk-3-0 \
	libnotify4 \
	libnss3 \
	libxkbfile1 \
	libxss1 \
	libxtst6 \
        libx11-xcb-dev \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# download the source and install atom
ENV ATOM_VERSION 1.36.0
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
	&& dpkg -i /tmp/atom-amd64.deb \
	&& rm -rf /tmp/*.deb

RUN  mkdir /root/.atom \
     && echo '"*":\n  core:\n    telemetryConsent: "no"\n  welcome:\n    showOnStartup: false' > /root/.atom/config.cson

# install eslint, rubocop and reek
RUN apt-get update && apt-get install -y curl software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update && apt-get install -y nodejs build-essential
ENV PKG=eslint-config-airbnb-base
RUN npm info "$PKG" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$PKG"
RUN gem install rubocop
RUN gem install rubocop-performance
RUN gem install rubocop-rspec
RUN gem install reek

# autorun atom
ENTRYPOINT [ "atom", "--foreground" ]


# install atom plugins
COPY atom-packages /tmp/
RUN apm install --packages-file /tmp/atom-packages
