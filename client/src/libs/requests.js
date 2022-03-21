export default {
  baseURL: 'http://localhost:8080',
  options: {
    method: '',
    headers: {
      'Content-Type': 'application/json'
    },
    body: ''
  },

  async post(relURL, data) {
    this.options.method = 'POST';
    this.options.body = JSON.stringify(data);
    return await this.send(relURL);
  },

  async patch(relURL, data) {
    this.options.method = 'PATCH';
    this.options.body = JSON.stringify(data);
    return await this.send(relURL);
  },

  async send(relURL) {
    const res = await fetch(this.baseURL + relURL, this.options);
    if(!res.ok) {
      console.log('HTTP-Error:', res.status);
    }
    return res.json();
  },

  async get(relURL) {
    const res = await fetch(this.baseURL + relURL);
    return res.json();
  },

  async delete(relURL) {
    const res = await fetch(this.baseURL + relURL, {
      method: 'DELETE'
    });
    if(!res.ok) {
      console.log('HTTP-Error:', res.status);
      return res.ok;
    }
    return await res.json();
  }
}