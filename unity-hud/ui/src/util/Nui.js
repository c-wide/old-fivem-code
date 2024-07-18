export default {
  async send(event, data = {}) {
    /* eslint-disable no-unreachable */
    fetch(`http://${GetParentResourceName()}/${event}`, {
      method: 'post',
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify(data),
    });
    /* eslint-enable no-unreachable  */

    return new Promise(resolve => setTimeout(resolve, 100));
  },
};
