FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY ./app ./app
COPY ./db  ./db
EXPOSE 3000
CMD [ "node", "start.js" ]
