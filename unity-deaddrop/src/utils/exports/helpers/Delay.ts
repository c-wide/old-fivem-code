/**
 * Basically Citizen.Wait() for Javascript
 */
export const Delay = (ms: number): Promise<{}> =>
  new Promise((res): NodeJS.Timeout => setTimeout(res, ms));
