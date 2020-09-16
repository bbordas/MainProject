FROM node:12 AS build

ARG PROJECT_NAME
ENV PROJECT $PROJECT_NAME

ENV workdir /home/node/MainProject
WORKDIR $workdir
ADD . /home/node/MainProject

RUN npm install --only=prod --quiet
RUN npx env-install --quiet
RUN NAME=$PROJECT npm run build

FROM nginx:1.17.1-alpine
ARG PROJECT_NAME
ENV PROJECT $PROJECT_NAME

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

RUN echo $PROJECT
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=build /home/node/MainProject/dist/${PROJECT} /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]