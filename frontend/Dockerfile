FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies without lockfile so platform-specific optional deps resolve correctly
RUN npm install --no-package-lock

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]