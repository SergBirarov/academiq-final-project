import { Router } from 'express';
import { getWeekendSchedule, postWeekendSchedule as putWeekendSchedule, updateWeekendSchedule } from './weekendSchedule.controller';

const WeekendScheduleRouter = Router();

WeekendScheduleRouter
  //Luctures & Students
  .get('/', getWeekendSchedule)
  //Mazkira
  .put('/set', putWeekendSchedule)
  .post('/update', updateWeekendSchedule)


export default WeekendScheduleRouter; 
