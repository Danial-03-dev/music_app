import { NextFunction, Request, Response } from "express";
import { createUploadAudio } from "../file_transfer/upload/audioUpload";

export const uploadAudioAndImageMiddleware = (req: Request, res: Response, next: NextFunction) => {
    const uploadAudio = createUploadAudio();

    uploadAudio.fields([
        { name: 'audio', maxCount: 1 },
        { name: 'image', maxCount: 1 },
    ])(req, res, (err: any) => {
        if (err) {
            console.error("Error during file upload:", err);
            return next(err);
        }
        next();
    });
};

