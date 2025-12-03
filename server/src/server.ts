import dotenv from 'dotenv';
import { app } from './app';
import { connectDB } from './database';

dotenv.config();

const PORT = process.env.PORT || 3000;

async function startServer() {
    await connectDB();

    app.listen(PORT, () => {
        console.log(`Server running at http://localhost:${PORT}`);
    });
}

startServer();