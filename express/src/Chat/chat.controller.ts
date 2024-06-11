import { Request, Response } from 'express';

export async function getMsg(req: Request, res: Response) {
  res.json({ msg: "getMsg" });
}
export async function sendMsg(req: Request, res: Response) {
  res.json({ msg: "sendMsg" });
}

export async function generateKey(req: Request, res: Response) {
  res.json({ msg: "generateKey" });
}
