import dotenv from 'dotenv';
import { app } from './app';
import { connectDB } from './database';

dotenv.config();

const PORT = Number(process.env.PORT) || 3000;

async function startServer() {
    await connectDB();

    
    app.listen(PORT, '0.0.0.0', () => {
        console.log(`Server running at http://localhost:${PORT}`);
    });
}

startServer();