import mongoose from "mongoose";

let isConnected = false;

export const connectDB = async () => {
    if (isConnected) return; // reuse existing connection

    try {
        console.log('Connecting to MongoDB...');
        await mongoose.connect(process.env.MONGO_URI as string);
        isConnected = true;
        console.log("MongoDB connected");
    } catch (error) {
        console.error("MongoDB connection error:", error);
        throw error; // do not exit in serverless, let Vercel handle
    }
};
