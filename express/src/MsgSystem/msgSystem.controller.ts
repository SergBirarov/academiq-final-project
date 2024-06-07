import { Request, Response } from 'express';


export async function readMsg(req: Request, res: Response) {
  res.json({msg: "ReadMsg"});
}
export async function createMsg(req: Request, res: Response) {
  res.json({msg: "CreateMsg"});
}
export async function deleteMsg(req: Request, res: Response) {
  res.json({msg: "DeleteMsg"});
}
