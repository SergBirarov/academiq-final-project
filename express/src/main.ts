import express from 'express';
import courseNoteRouter from './CourseNote changeName/courseNote.routes';

//env configs
const PORT = 5555;

//create the server
const app = express();

//server config
app.use(express.json());

//create routes
app.use('/api/users', courseNoteRouter);

//run the server
app.listen(PORT, () => console.log(`[Server] running at http://localhost:${PORT}`));

