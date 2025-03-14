#FROM node:20.17-alpine3.20@sha256:2d07db07a2df6830718ae2a47db6fedce6745f5bcd174c398f2acdda90a11c03
#FROM node:alpine3.20@sha256:1b4d82a2bee3b5ea9a9048bd3b326220ac77065a84cbef339a8f41c698f0ec66
FROM node:alpine3.20@sha256:0b5e04c9ee063720e29b72a19df52d613459b518ffdfd4ea9870336178dcbf4e

RUN apk update && apk upgrade && apk add --no-cache make gcc g++ curl
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add curl-dev python3-dev

# zorg dat sqlite later bij de yarn install een python executable kan vinden
RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

WORKDIR /myapp

EXPOSE 80
COPY package.json  .
RUN yarn install 

COPY .meshrc.yaml .

COPY jsons ./jsons
     
CMD ["yarn", "mesh", "dev"]
