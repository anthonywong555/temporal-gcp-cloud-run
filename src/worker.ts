import { loadClientConnectConfig } from '@temporalio/envconfig';
import { NativeConnection, Worker } from '@temporalio/worker';
import * as activities from './activities';

const workflowOption = () =>
  process.env.NODE_ENV === 'development'
    ? { workflowsPath: require.resolve('./workflows') }
    : { workflowBundle: { codePath: require.resolve('../workflow-bundle.js') } };

async function run() {
  // Reads TEMPORAL_PROFILE and TEMPORAL_CONFIG_FILE from the environment.
  // Env vars (e.g. TEMPORAL_API_KEY in GCP) override the profile's values.
  const config = loadClientConnectConfig();

  console.log(
    `Connecting as profile '${process.env.TEMPORAL_PROFILE ?? 'default'}' ` +
      `to ${config.connectionOptions.address} (namespace: ${config.namespace})`
  );

  const connection = await NativeConnection.connect(config.connectionOptions);
  const taskQueue = process.env.TEMPORAL_TASK_QUEUE || 'production-sample';

  try {
    const worker = await Worker.create({
    connection,
    namespace: config.namespace,
    taskQueue,
    ...workflowOption(),
    activities,
    /*
    workerDeploymentOptions: {
      version: { deploymentName: 'my-app', buildId: 'build-1' },
      useWorkerVersioning: true,
      defaultVersioningBehavior: 'PINNED'
    }
    */
    });

    await worker.run();
  } finally {
    await connection.close();
  }
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});
