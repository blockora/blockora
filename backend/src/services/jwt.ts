import jwt from "jsonwebtoken";
import { cfg } from "../config.js";

export function issueKycVC(userId: string) {
  const payload = {
    sub: userId,
    kyc_status: "verified",
    kyc_level: "basic",
    iat: Math.floor(Date.now()/1000),
    exp: Math.floor(Date.now()/1000) + 3600*24*365 // 1 saal
  };
  return jwt.sign(payload, cfg.jwtPrivatePem, { algorithm: "RS256" });
}
