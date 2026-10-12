FROM node:24-alpine 

WORKDIR /app

COPY package*.json .

RUN npm ci --omit=dev

RUN rm -rf /usr/local/lib/node_modules/npm && rm -rf /usr/local/bin/npm && rm -rf /usr/local/bin/npx

COPY . .

EXPOSE 5000

CMD ["node","server.js"]

 
