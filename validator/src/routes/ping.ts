import { Router } from "express";

const router = Router();

// Simple health/ping route
router.get("/ping", (_req, res) => {
  res.json({ ok: true });
});

export default router;
