import mongoose from "mongoose";
import multer from "multer";
import { GridFsStorage } from "multer-gridfs-storage";
import { AUDIO_BUCKET_NAME, IMAGE_BUCKET_NAME } from "../../constants/constants";

const MAX_AUDIO_SIZE = 10 * 1024 * 1024; // 10MB

export const createAudioStorage = () => {
    if (!mongoose.connection.db) {
        throw new Error("Mongoose is not connected to the database");
    }

    return new GridFsStorage({
        url: process.env.MONGO_URI!,
        // db: mongoose.connection.db,
        file: (_req, file) => {
            return new Promise((resolve, reject) => {
                let bucketName: string;

                if (file.fieldname === 'audio') {
                    bucketName = AUDIO_BUCKET_NAME;
                } else if (file.fieldname === 'image') {
                    bucketName = IMAGE_BUCKET_NAME;
                } else {
                    return reject(new Error("Invalid file field"));
                }

                resolve({
                    filename: `${Date.now()}-${file.originalname}`,
                    bucketName,
                    metadata: { fieldname: file.fieldname },
                });
            });
        },
    });
}

export const createUploadAudio = () => {
    return multer({
        storage: createAudioStorage() as unknown as multer.StorageEngine,
        limits: { fileSize: MAX_AUDIO_SIZE },
    });
};