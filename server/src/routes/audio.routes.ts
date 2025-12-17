import { Router } from "express";
import { uploadAudioController } from "../controllers/audio/upload_audio.controller";
import { uploadAudioAndImageMiddleware } from "../middleware/audio.middleware";
import { authMiddleware } from "../middleware/auth.middleware";

export const audioRouter = Router();


audioRouter.post('/upload', authMiddleware, uploadAudioAndImageMiddleware, uploadAudioController);