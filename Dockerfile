FROM node:24-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
RUN npm run build:workflow

FROM node:24-slim

ARG NODE_ENV=production
ARG BUILD_ID=build-1
ARG TEMPORAL_PROFILE=preview
ARG TEMPORAL_TASK_QUEUE=production-sample
ENV NODE_ENV=${NODE_ENV} \
    BUILD_ID=${BUILD_ID} \
    TEMPORAL_PROFILE=${TEMPORAL_PROFILE} \
    TEMPORAL_TASK_QUEUE=${TEMPORAL_TASK_QUEUE} \
    TEMPORAL_CONFIG_FILE=/etc/temporalio/temporal.toml

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=build /app/lib ./lib
COPY --from=build /app/workflow-bundle.js ./workflow-bundle.js
COPY temporal.toml /etc/temporalio/temporal.toml

USER node

CMD ["node", "lib/worker.js"]