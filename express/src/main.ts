import express from 'express';
import courseNoteRouter from './CourseNote changeName/courseNote.routes';
import adminRouter from './Admin/admin.routes';
import assignmentRouter from './Assignments/assignments.routes';
import msgSystemRouter from './MsgSystem/msgSystem.routes';
import weekendScheduleRouter from './WeekendSchedule/weekendSchedule.routes';

//env configs
const PORT = 5555;

//create the server
const app = express();

//server config
app.use(express.json());

//create routes
app.use('/api/courseNote', courseNoteRouter);
app.use('/api/admin', adminRouter);
app.use('/api/assignment', assignmentRouter);
app.use('/api/msg', msgSystemRouter);
app.use('/api/weekendSchedule', weekendScheduleRouter);

//run the server
app.listen(PORT, () => console.log(`[Server] running at http://localhost:${PORT}`));

