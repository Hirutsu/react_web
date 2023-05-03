FROM node:latest
WORKDIR /app
COPY ["react-sneakers.Front/package*.json", "frontend/"]

WORKDIR /app/frontend
RUN npm install
COPY ["react-sneakers.Front/", "./"]

EXPOSE 3000
CMD ["npm", "start"]