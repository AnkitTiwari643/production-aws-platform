const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
app.use(express.json());

app.get('/health', (req, res) => res.status(200).send('ok'));

let coupons = [{ code: 'BFCM20', discount: 20 }];

app.get('/api/coupons', (req, res) => res.json({ coupons, env: process.env.ENVIRONMENT || 'dev' }));
app.post('/api/coupons', (req, res) => {
  const { code, discount } = req.body || {};
  if (!code) return res.status(400).json({ error: 'code required' });
  coupons.push({ code, discount: discount ?? 10 });
  res.status(201).json({ ok: true });
});

if (require.main === module) {
  app.listen(PORT, () => console.log(`coupon-service on ${PORT}`));
}
module.exports = app;
