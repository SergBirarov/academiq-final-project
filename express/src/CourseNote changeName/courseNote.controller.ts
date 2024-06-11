import { Request, Response } from 'express';

export async function uploadToNote(req: Request, res: Response) {
  res.json({ msg: "uploadToNote" });
}
export async function deleteFromNote(req: Request, res: Response) {
  res.json({ msg: "deleteFromNote" });
}
export async function createNote(req: Request, res: Response) {
  res.json({ msg: "createNote" });
}
