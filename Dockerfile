FROM node:12 AS build

ARG GITHUB_TOKEN
ARG PROJECT_NAME
RUN export GITHUB_TOKEN=$GITHUB_TOKEN

ENV workdir /home/node/MainProject
ENV ADDIN $PROJECT_NAME
WORKDIR ${workdir}
ADD . /home/node/MainProject

RUN npm install --only=prod --quiet
RUN npm run build

EXPOSE 9000