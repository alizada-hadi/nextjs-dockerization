
# State 1: Build the application
FROM node:20-alpine AS builder

WORKDIR /app

# installing the required dependencies

COPY package*.json ./

RUN npm install

# copy the rest of the application

COPY . .


# build the nextjs application

RUN npm run build

# Stage 2: serve the application

FROM node:20-alpine

WORKDIR /app

# Copy the built files from the builder stage

COPY --from=builder /app ./

# Install only production dependencies

RUN npm install --only=production

# Expose the port

EXPOSE 3000

# start the application

CMD ["npm", "start"]



