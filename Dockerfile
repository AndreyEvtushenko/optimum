FROM node:16.15
WORKDIR /optimum
COPY package.json .
RUN npm install
COPY . .
ENV PORT=80
CMD ["node", "index.js"]