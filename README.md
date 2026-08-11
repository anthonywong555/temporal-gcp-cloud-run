# temporal-gcp-cloud-run

This project is based on the Temporal [samples-typescript/production](https://github.com/temporalio/samples-typescript/tree/main/production)

### Getting started

### Local Testing without Docker

1. `temporal server start-dev` to start [Temporal Server](https://github.com/temporalio/cli/#installation).
1. `npm install` to install dependencies.
1. `npm run start.watch` to start the Worker.
1. In another shell, `temporal worker deployment describe --name my-app` see the list of deployments.
1. `temporal worker deployment set-current-version --deployment-name my-app --build-id build-1` deploy this worker.
1. `npm run workflow` to run the Workflow.

The Workflow should return:

```
Hello, Temporal!
```

#### Running this sample in production

1. `npm run build` to build the Worker script and Activities code.
1. `npm run build:workflow` to build the Workflow code bundle.
1. `NODE_ENV=production node lib/worker.js` to run the production Worker.

### Local Testing with Docker

1. `docker compose up -d` to spin up the worker and Temporal.
1. `docker compose exec temporal temporal worker deployment describe --name my-app` see a list of deployements.
1. `docker compose exec temporal temporal worker deployment set-current-version --deployment-name my-app --build-id build-1` deploy the worker.

### Google Cloud Testing

### Resources 
- [Deploy a Serverless Worker on GCP Cloud Run](https://docs.temporal.io/production-deployment/worker-deployments/serverless-workers/cloud-run)