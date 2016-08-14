FROM node:6.3.1

MAINTAINER tom.jcox@outlook.com

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
