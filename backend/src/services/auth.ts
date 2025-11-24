import { Request, Response, NextFunction } from "express";

export function requireAttestor(req: Request, res: Response, next: NextFunction){
  const hdr = req.headers["x-attestor-token"];
  if(!hdr || hdr !== process.env.ATTEST_ADMIN_TOKEN){
    return res.status(401).json({ok:false, err:"unauthorized"});
  }
  next();
}
