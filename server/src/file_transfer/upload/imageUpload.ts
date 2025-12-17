import { GridFsStorage } from "multer-gridfs-storage";
import { IMAGE_BUCKET_NAME } from "../../constants/constants";
import mongoose from "mongoose";
import multer from "multer";

const MAX_IMAGE_SIZE = 5 * 1024 * 1024; // 5MB

export const createImageStorage = () => {
    if (!mongoose.connection.db) {
        throw new Error("Mongoose is not connected to the database");
    }

    return new GridFsStorage({
        db: mongoose.connection.db,
        file: (_req, file) => {
            if (!file.mimetype.startsWith("image/")) {
                throw new Error("Invalid image file");
            }
            return { filename: `${Date.now()}-${file.originalname}`, bucketName: IMAGE_BUCKET_NAME };
        },
    });
}


export const createUploadImage = () => {
    return multer({
        storage: createImageStorage() as unknown as multer.StorageEngine,
        limits: { fileSize: MAX_IMAGE_SIZE },
    });
};