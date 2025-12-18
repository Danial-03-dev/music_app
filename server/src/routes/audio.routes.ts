import { Router } from "express";
import { getAudioListController } from "../controllers/audio/get_audio_list.controller";
import { getMediaController } from "../controllers/audio/get_media.controller";
import { uploadAudioController } from "../controllers/audio/upload_audio.controller";
import { uploadAudioAndImageMiddleware } from "../middleware/audio.middleware";
import { authMiddleware } from "../middleware/auth.middleware";
import { AUDIO_BUCKET_NAME, IMAGE_BUCKET_NAME } from "../constants/constants";

export const audioRouter = Router();

audioRouter.get('/image/:id', authMiddleware, getMediaController(IMAGE_BUCKET_NAME));
audioRouter.get('/audio/:id', authMiddleware, getMediaController(AUDIO_BUCKET_NAME));
audioRouter.get('/list', authMiddleware, getAudioListController);
audioRouter.post('/upload', authMiddleware, uploadAudioAndImageMiddleware, uploadAudioController);