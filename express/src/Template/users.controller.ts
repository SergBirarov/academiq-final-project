import { Request, Response } from 'express';

export async function findAllUsers(req: Request, res: Response) {
  res.json([
    { firstName: 'Momik', planet: 'Epsilon' },
    { firstName: 'Zozik', planet: 'Barsum' }
  ]);

  //retrun [{},{}]
}

export async function registerUser(req: Request, res: Response) {
  res.json({msg: "registerUser"});
}
export async function loginUser(req: Request, res: Response) {
  res.json({msg: "loginUser"});
}
export async function updateUser(req: Request, res: Response) {
  res.json({msg: "updateUser"});
}
export async function deleteUser(req: Request, res: Response) {
  res.json({msg: "deleteUser"});
}
