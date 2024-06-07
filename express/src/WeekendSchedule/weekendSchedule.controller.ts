import { Request, Response } from 'express';

export async function getWeekendSchedule(req: Request, res: Response) {
  res.json({msg: "GetWeekendSchedule"});
}
//For Lucturer
export async function postWeekendSchedule(req: Request, res: Response) {
  res.json({msg: "PostWeekendSchedule"});
}
export async function updateWeekendSchedule(req: Request, res: Response) {
  res.json({msg: "UpdateWeekendSchedule"});
}