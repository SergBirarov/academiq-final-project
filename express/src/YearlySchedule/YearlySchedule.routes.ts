import { Router } from 'express';
import { GetYearlySchedule, PostYearlySchedule,UpdateYearlySchedule } from './YearlySchedule.controller';

const YearlyScheduleRouter = Router();

YearlyScheduleRouter
  .get('/', GetYearlySchedule)
  .post('/setSchedule', PostYearlySchedule)
  .put('/updateSchedule', UpdateYearlySchedule)

export default YearlyScheduleRouter; 
