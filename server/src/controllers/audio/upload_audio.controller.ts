import { Request, Response } from "express";
import mongoose from "mongoose";
import { treeifyError } from "zod";
import { AUDIO_BUCKET_NAME, IMAGE_BUCKET_NAME } from "../../constants/constants";
import { AudioModel } from "../../models/audio.model";
import { AudioUploadSchema } from "../../schemas/audio.schemas";
import { GridFsFile } from "../../types/girdfs";

export const uploadAudioController = async (req: Request, res: Response) => {
    const files = req.files as {
        [fieldname: string]: Express.Multer.File[];
    };

    const audioFile = files['audio']?.[0] as GridFsFile;
    const imageFile = files['image']?.[0] as GridFsFile;

    const deleteAudio = async () => {
        if (!audioFile?.id) return;


        const id = new mongoose.Types.ObjectId(audioFile.id);
        const bucket = new mongoose.mongo.GridFSBucket(mongoose.connection.db!, {
            bucketName: AUDIO_BUCKET_NAME,
        });
        await bucket.delete(id).catch((err) => {
            console.error("Failed to delete orphan file:", err);
        });
    }

    const deleteImage = async () => {
        if (!imageFile?.id) return;


        const id = new mongoose.Types.ObjectId(imageFile.id);
        const bucket = new mongoose.mongo.GridFSBucket(mongoose.connection.db!, {
            bucketName: IMAGE_BUCKET_NAME,
        });
        await bucket.delete(id).catch((err) => {
            console.error("Failed to delete orphan file:", err);
        });
    }



    if (!audioFile || !audioFile.id) {
        await deleteImage();
        return res.status(400).json({ message: "Audio file is required" });
    }

    if (!imageFile || !imageFile.id) {
        await deleteAudio();
        return res.status(400).json({ message: "Image file is required" });
    }


    const parseResult = AudioUploadSchema.safeParse(req.body);

    if (!parseResult.success) {
        await deleteAudio();
        await deleteImage();

        return res.status(400).json({
            message: "Invalid audio upload data",
            errors: treeifyError(parseResult.error),
        });
    }

    try {
        const audio = await AudioModel.create({
            name: parseResult.data.name,
            artist: parseResult.data.artist,
            color: parseResult.data.color,
            audioId: new mongoose.Types.ObjectId(audioFile.id),
            imageId: new mongoose.Types.ObjectId(imageFile.id),
            mimeType: audioFile.mimetype,
            size: audioFile.size,
        });

        res.status(201).json({ message: "Audio uploaded successfully", audio });

    } catch (error) {
        console.error("Error saving audio to database:", error);
        await deleteAudio();
        await deleteImage();

        res.status(500).json({ message: "Internal server error" });
    }

}