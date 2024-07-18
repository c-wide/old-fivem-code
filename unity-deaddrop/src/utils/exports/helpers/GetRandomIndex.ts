/**
 * Helper function to generate a random index.
 * Loop over the array provided and if the generated
 * index matches, generate a new index.
 */
export const GetRandomIndex = (dumpsterArray): Promise<number> =>
  new Promise(res => {
    let randomIndex = null;

    while (!randomIndex) {
      randomIndex = Math.floor(Math.random() * 10000);

      if (dumpsterArray.length === 0) {
        break;
      }

      for (const dumpster of dumpsterArray) {
        if (randomIndex === dumpster.index) {
          randomIndex = null;
        }
      }
    }

    res(randomIndex);
  });
