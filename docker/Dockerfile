FROM node:latest
ADD . /app
WORKDIR /app
RUN apt-get update && apt-get install -y curl
RUN npm install
ENV DB_PASSWORD=Password123!
EXPOSE 22 3000
CMD ["npm", "start"]
