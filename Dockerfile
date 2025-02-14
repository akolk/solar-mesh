#FROM node:20.17-alpine3.20@sha256:2d07db07a2df6830718ae2a47db6fedce6745f5bcd174c398f2acdda90a11c03
FROM node:alpine3.20@sha256:5cda29a9858e1230b081e365d74b972fbe2fbe7fc8256537578367b2212ef078

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
