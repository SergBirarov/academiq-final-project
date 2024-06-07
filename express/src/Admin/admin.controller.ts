import { Request, Response } from 'express';


export async function insertToTable(req: Request, res: Response) {
  res.json({msg: "insertToTable"});
}

export async function deleteFromTable(req: Request, res: Response) {
  res.json({msg: "deleteFromTable"});
}
