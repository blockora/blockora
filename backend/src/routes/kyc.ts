import { Router } from "express";
import multer from "multer";
const upload = multer({ dest: "tmp/" });
const r = Router();

// KYC start
r.post("/start", (req, res) => {
  // TODO (Hindi): Production me wallet signature verify karo
  const { userId } = req.body;
  return res.json({ ok: true, uploadToken: `kyc_${userId}_${Date.now()}` });
});

// Docs upload
r.post("/upload", upload.array("docs", 4), async (req, res) => {
  // TODO (Hindi): Files ko S3/IPFS me store karo + 3rd-party verification trigger
  return res.json({ ok: true, message: "Docs received, pending verification" });
});

export default r;
