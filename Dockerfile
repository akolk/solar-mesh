#FROM node:20.17-alpine3.20@sha256:2d07db07a2df6830718ae2a47db6fedce6745f5bcd174c398f2acdda90a11c03
FROM node:alpine3.20@sha256:1467ea23cce893347696b155b9e00e7f0ac7d21555eb6f27236f1328212e045e

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
