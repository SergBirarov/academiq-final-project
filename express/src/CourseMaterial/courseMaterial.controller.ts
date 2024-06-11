import { Request, Response } from 'express';
export async function getCourseMaterial(req: Request, res: Response) {
  res.json({ msg: "getCourseMaterial" });
}
export async function uploadToCourse(req: Request, res: Response) {
  res.json({ msg: "uploadToCourse" });
}
export async function deleteFromCourse(req: Request, res: Response) {
  res.json({ msg: "deleteFromCourse" });
}
export async function setVisibility(req: Request, res: Response) {
  res.json({ msg: "setVisibility" });
}
