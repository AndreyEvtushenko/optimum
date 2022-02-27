export default {
  baseURL: 'http://localhost:8080',

  async sendDate(pickedDateString) {
    const res = await fetch(this.baseURL + 
      `/api/date/${pickedDateString}`);
    if(!res.ok) {
      console.log('HTTP-Error:', res.status);
    }
  },

  async get(relURL) {
    const res = await fetch(this.baseURL + relURL);
    return res.json();
  }
}