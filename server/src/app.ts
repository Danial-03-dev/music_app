import express from 'express';
import { authRouter } from './routes/auth.routes';
import cors from "cors";

export const app = express();

app.use(cors());

// Middleware
app.use(express.json());

// Routes
app.use('/auth', authRouter);