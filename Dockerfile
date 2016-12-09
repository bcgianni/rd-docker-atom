# DESCRIPTION: Create the atom editor in a container
#
#	# Build atom image
#	docker build -t rd-docker-atom .
#
#	docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $PWD:PWD -w $PWD rd-docker-atom
#
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
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxkbfile1 \
	libxss1 \
	libxtst6 \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# download the source and install atom
ENV ATOM_VERSION 1.12.6
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
	&& dpkg -i /tmp/atom-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

RUN  mkdir /root/.atom \
     && echo '"*":\n  core:\n    telemetryConsent: "no"\n  welcome:\n    showOnStartup: false' > /root/.atom/config.cson

# install eslint, rubocop and reek
RUN apt-get update && apt-get install -y npm
ENV PKG=eslint-config-airbnb-base
RUN npm info "$PKG" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$PKG"
RUN gem install rubocop
RUN gem install reek

# install atom plugins
RUN apm install linter linter-eslint
RUN apm install linter-rubocop
RUN apm install linter-reek

# autorun atom
ENTRYPOINT [ "atom", "--foreground" ]
