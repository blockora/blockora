import { Router } from "express";
import { issueKycVC } from "../services/jwt.js";
import { requireAttestor } from "../services/auth.js";
const r = Router();

// VC issue (secure in prod)
r.post("/issue", requireAttestor, (req, res) => {
  const { userId, passed } = req.body;
  if (!passed) return res.status(400).json({ ok:false, err: "not passed" });
  const vc = issueKycVC(userId);
  return res.json({ ok:true, vc });
});

export default r;
