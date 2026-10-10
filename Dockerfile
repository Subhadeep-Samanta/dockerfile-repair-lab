FROM node:22-alpine

WORKDIR /app

# Copy dependency manifests first for better layer caching
COPY package.json package-lock.json ./

# Install dependencies from the lockfile
RUN npm ci --omit=dev

# Copy the application files
COPY app.js ./
COPY src/ ./src/
COPY public/ ./public/

EXPOSE 8080

CMD ["npm", "start"]
