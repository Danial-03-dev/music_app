import express from 'express';
import { authRouter } from './routes/auth.routes';
import cors from "cors";
import { audioRouter } from './routes/audio.routes';
import multer from 'multer';

export const app = express();

app.use(cors());

// Middleware
app.use(express.json());

// Routes
app.use('/auth', authRouter);
app.use('/audio', audioRouter);

// Global error handler (after all routes)
app.use((err: any, _req: express.Request, res: express.Response, _next: express.NextFunction) => {
    if (err instanceof multer.MulterError) {
        if (err.code === "LIMIT_FILE_SIZE") {
            return res.status(400).json({ message: "File too large" });
        }
        return res.status(400).json({ message: err.message });
    }

    console.error(err); // Log other errors
    res.status(500).json({ message: "Internal server error" });
});