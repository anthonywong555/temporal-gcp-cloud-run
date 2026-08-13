import { setWorkflowOptions, proxyActivities } from '@temporalio/workflow';
import type * as activities from './activities';

const { greet } = proxyActivities<typeof activities>({
  startToCloseTimeout: '1 minute',
});

//setWorkflowOptions({ versioningBehavior: 'PINNED' }, example);
export async function example(name: string): Promise<string> {
  await greet(name);
  await greet(name);
  return greet(name);
}