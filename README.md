# temporal-gcp-cloud-run

This project is based on the Temporal [samples-typescript/production](https://github.com/temporalio/samples-typescript/tree/main/production)

### Getting started

### Local Testing

1. `temporal server start-dev` to start [Temporal Server](https://github.com/temporalio/cli/#installation).
1. `npm install` to install dependencies.
1. `npm run start.watch` to start the Worker.
1. In another shell, `npm run workflow` to run the Workflow.

The Workflow should return:

```
Hello, Temporal!
```

### Running this sample in production

1. `npm run build` to build the Worker script and Activities code.
1. `npm run build:workflow` to build the Workflow code bundle.
1. `NODE_ENV=production node lib/worker.js` to run the production Worker.

### Cloud Testing


### Resources 
- [Deploy a Serverless Worker on GCP Cloud Run](https://docs.temporal.io/production-deployment/worker-deployments/serverless-workers/cloud-run)