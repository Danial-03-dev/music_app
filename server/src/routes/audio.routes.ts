import { Router } from "express";
import { getAudioListController } from "../controllers/audio/get_audio_list.controller";
import { getMediaController } from "../controllers/audio/get_media.controller";
import { uploadAudioController } from "../controllers/audio/upload_audio.controller";
import { uploadAudioAndImageMiddleware } from "../middleware/audio.middleware";
import { authMiddleware } from "../middleware/auth.middleware";
import { AUDIO_BUCKET_NAME, IMAGE_BUCKET_NAME } from "../constants/constants";
import { getAudioSignedUrlController } from "../controllers/audio/get_audio_signed_url.controller";
import { addFavoriteAudioController } from "../controllers/audio/add_favorite_audio.controller";
import { removeFavoriteAudioController } from "../controllers/audio/remove_favorite_audio.controller";
import { getFavoriteAudiosController } from "../controllers/audio/get_favorite_audios.controller";

export const audioRouter = Router();

audioRouter.get('/image/:id', authMiddleware, getMediaController(IMAGE_BUCKET_NAME));
audioRouter.get('/signed-url/:id', authMiddleware, getAudioSignedUrlController);
audioRouter.get('/stream/:id', getMediaController(AUDIO_BUCKET_NAME, true));
audioRouter.get('/list', authMiddleware, getAudioListController);
audioRouter.post('/upload', authMiddleware, uploadAudioAndImageMiddleware, uploadAudioController);

// Favorite audio routes
audioRouter.get('/favorite', authMiddleware, getFavoriteAudiosController);
audioRouter.post('/favorite', authMiddleware, addFavoriteAudioController);
audioRouter.delete('/favorite', authMiddleware, removeFavoriteAudioController);