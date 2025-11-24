import express from "express";
import cors from "cors";
import kyc from "./routes/kyc.js";
import attestation from "./routes/attestation.js";
import { cfg } from "./config.js";

const app = express();
app.use(cors());
app.use(express.json());

app.use("/kyc", kyc);
app.use("/attestation", attestation);

app.get("/health", (_,res)=> res.json({ok:true, url: cfg.serverUrl}));

app.listen(cfg.port, ()=> console.log(`API running on ${cfg.port} → ${cfg.serverUrl}`));
