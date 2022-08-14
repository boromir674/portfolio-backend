
FROM node:16-slim as base

# 1. Change working directory
WORKDIR /app

# 2. Install app dependencies using cached layers, when applicable
COPY package*.json ./
COPY yarn.lock ./

# use cached docker layer (instead of running below command) if no changes are
# found in glob/files package*.json (ie package.json, yarn.lock & package-lock.json)
RUN yarn install

FROM base AS build
# 3. Add code
# COPY . .
COPY config config
COPY database database
COPY public public
COPY src src
COPY .env .
COPY favicon.ico .
COPY README.md .
COPY tsconfig.json .


# 4. Build
ENV NODE_ENV production

RUN yarn build

# 5. Expose port
EXPOSE 1337

# 6. Define default command to run
CMD ["yarn", "start"]
