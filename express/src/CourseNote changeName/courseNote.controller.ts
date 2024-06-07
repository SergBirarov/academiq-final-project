import { Request, Response } from 'express';

export async function uploadToNote(req: Request, res: Response) {
  res.json({msg: "registerUser"});
}
export async function deleteFromNote(req: Request, res: Response) {
  res.json({msg: "loginUser"});
}
export async function createNote(req: Request, res: Response) {
  res.json({msg: "updateUser"});
}
