import http from 'k6/http';
import { check } from 'k6';
export const options = { stages: [{ duration: '1m', target: 50 }, { duration: '2m', target: 50 }, { duration: '30s', target: 0 }], thresholds: { http_req_failed: ['rate<0.01'], http_req_duration: ['p(99)<500'] } };
const URL = __ENV.URL || 'http://localhost:3000';
export default function () {
  const r1 = http.get(`${URL}/health`);
  check(r1, { 'health 200': (r) => r.status === 200 });
  const r2 = http.get(`${URL}/api/coupons`);
  check(r2, { 'coupons 200': (r) => r.status === 200 });
}
