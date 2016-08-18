FROM node:6.3.1

MAINTAINER tom.jcox@outlook.com


# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
org.label-schema.docker.dockerfile="/Dockerfile" \
org.label-schema.license="MIT" \
org.label-schema.name="azurenodeiot" \
org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.vcs-type="e.g. Git" \
org.label-schema.vcs-url="e.g. https://github.com/IACubed/azurenodeiot"

# Set non-root user. Need to figure this out.
# RUN groupadd -r app && useradd -r -g app app

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Expose standard port. Not needed.
# EXPOSE 8080

# Run the command to start the
CMD [ "node", "device.js" ]
