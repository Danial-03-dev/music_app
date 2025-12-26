import mongoose, { Types } from "mongoose";
import { IMAGE_BUCKET_NAME } from "../../constants/constants";

export const deleteImage = async (imageId: Types.ObjectId) => {
    if (!imageId) return;

    const id = new mongoose.Types.ObjectId(imageId);
    const bucket = new mongoose.mongo.GridFSBucket(mongoose.connection.db!, {
        bucketName: IMAGE_BUCKET_NAME,
    });
    await bucket.delete(id).catch((err) => {
        console.error("Failed to delete orphan file:", err);
    });
}