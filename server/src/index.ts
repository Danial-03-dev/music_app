import dotenv from 'dotenv';
import { app } from './app';
import { connectDB } from './database';
import type { VercelRequest, VercelResponse } from '@vercel/node';

dotenv.config();

export default async function handler(
    req: VercelRequest,
    res: VercelResponse
) {
    try {
        await connectDB();
        return app(req, res);
    } catch (err) {
        console.error('Startup error:', err);
        return res.status(500).json({ message: 'Server failed to start' });
    }
}
