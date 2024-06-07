import { Request, Response } from 'express';


export async function getAssignment(req: Request, res: Response) {
  res.json({ msg: "getAssignment" });
}

//Lucture
export async function createAssignment(req: Request, res: Response) {
  res.json({ msg: "createAssignment" });
}
export async function editAssignment(req: Request, res: Response) {
  res.json({ msg: "editAssignment" });
}
export async function deleteAssignment(req: Request, res: Response) {
  res.json({ msg: "deleteAssignment" });
}

//Student
export async function submittingAssignment(req: Request, res: Response) {
  res.json({ msg: "submittingAssignment" });
}
