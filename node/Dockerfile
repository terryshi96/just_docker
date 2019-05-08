FROM node:10.15.2-stretch-slim as builder
RUN mkdir /app
WORKDIR /app
RUN npm set registry https://registry.npm.taobao.org
COPY package.json .
RUN npm install
COPY . .
ARG project
# docker build --build-arg myVarHere=value
RUN npm run build -- --project=$project --prod

FROM node:10.15.2-stretch-slim
RUN mkdir /app
WORKDIR /app
RUN npm set registry https://registry.npm.taobao.org
COPY --from=builder /app/server_package.json ./package.json
RUN npm install
COPY --from=builder /app/dist ./dist
COPY server.js .
COPY deploy ./deploy
ARG project 
ARG branch
ENV NODE_ENV=$branch
ENV PROJECT=$project
CMD node server.js --p $PROJECT
