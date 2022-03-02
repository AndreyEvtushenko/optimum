export default {
  baseURL: 'http://localhost:8080',

  async sendDate(pickedDateString) {
    const res = await fetch(this.baseURL + 
      `/api/date/${pickedDateString}`);
    if(!res.ok) {
      console.log('HTTP-Error:', res.status);
    }
  },

  async post(relURL, data) {
    const res = await fetch(this.baseURL + relURL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data),
    });
    if(!res.ok) {
      console.log('HTTP-Error:', res.status);
    }
  },

  async get(relURL) {
    const res = await fetch(this.baseURL + relURL);
    return res.json();
  }
}