# Step 1: Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files from the "app" folder
COPY ./app/package*.json ./

# Install dependencies
RUN npm install

# Copy all remaining project files
COPY ./app .

# Build the app
RUN npm run build

# Step 2: Production stage
FROM node:18-alpine AS runner

WORKDIR /app

# Copy built files and dependencies
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]

