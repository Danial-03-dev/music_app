import express from 'express';
import { authRouter } from './routes/auth.routes';

export const app = express();

// Middleware
app.use(express.json());

// Routes
app.use('/auth', authRouter);