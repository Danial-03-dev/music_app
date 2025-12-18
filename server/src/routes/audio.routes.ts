import { Router } from "express";
import { uploadAudioController } from "../controllers/audio/upload_audio.controller";
import { uploadAudioAndImageMiddleware } from "../middleware/audio.middleware";
import { authMiddleware } from "../middleware/auth.middleware";
import { getAudioListController } from "../controllers/audio/get_audio_list.controller";

export const audioRouter = Router();


audioRouter.get('/list', authMiddleware, getAudioListController);
audioRouter.post('/upload', authMiddleware, uploadAudioAndImageMiddleware, uploadAudioController);