import mongoose, { Types } from "mongoose";
import { AUDIO_BUCKET_NAME } from "../../constants/constants";

export const deleteAudio = async (audioId: Types.ObjectId) => {
    if (!audioId) return;

    const id = new mongoose.Types.ObjectId(audioId);
    const bucket = new mongoose.mongo.GridFSBucket(mongoose.connection.db!, {
        bucketName: AUDIO_BUCKET_NAME,
    });
    await bucket.delete(id).catch((err) => {
        console.error("Failed to delete orphan file:", err);
    });
}