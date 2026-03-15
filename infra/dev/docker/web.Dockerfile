FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install

# Copying the files is good for the initial build 
# even though Tilt syncs them later
COPY . .

EXPOSE 3000

ENV WATCHPACK_POLLING=true
ENV NODE_ENV=development

# Just run the script defined in package.json
CMD ["npm", "run", "dev"]