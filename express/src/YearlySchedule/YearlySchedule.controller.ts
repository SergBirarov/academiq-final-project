import { Request, Response } from 'express';

export async function findAllUsers(req: Request, res: Response) {
  // res.json([
  //   { firstName: 'Momik', planet: 'Epsilon' },
  //   { firstName: 'Zozik', planet: 'Barsum' }
  // ]);

}

export async function GetYearlySchedule(req: Request, res: Response) {
  res.json({msg: "GetYearlySchedule"});
}
export async function PostYearlySchedule(req: Request, res: Response) {
  res.json({msg: "loginUser"});
}
export async function UpdateYearlySchedule(req: Request, res: Response) {
  res.json({msg: "updateUser"});
}

