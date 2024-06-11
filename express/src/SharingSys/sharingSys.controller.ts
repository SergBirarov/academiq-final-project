import { Request, Response } from 'express';


export async function getByCouseId(req: Request, res: Response) {
  res.json({ msg: "getByCouseId" });

}
export async function shareToCourse(req: Request, res: Response) {
  res.json({ msg: "shareToCourse" });
}
export async function deleteSharing(req: Request, res: Response) {
  res.json({ msg: "deleteSharing" });
}
