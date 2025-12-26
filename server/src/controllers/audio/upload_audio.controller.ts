import { Request, Response } from "express";
import mongoose from "mongoose";
import { z } from "zod";
import { deleteAudio } from "../../file_transfer/upload/delete_audio";
import { deleteImage } from "../../file_transfer/upload/delete_image";
import { AudioModel } from "../../models/audio.model";
import { AudioUploadSchema } from "../../schemas/audio.schemas";
import { GridFsFile } from "../../types/girdfs";

export const uploadAudioController = async (req: Request, res: Response) => {
    const files = req.files as {
        [fieldname: string]: Express.Multer.File[];
    };

    const audioFile = files['audio']?.[0] as GridFsFile;
    const imageFile = files['image']?.[0] as GridFsFile;

    const audioId = audioFile?.id;
    const imageId = imageFile?.id;

    if (!audioFile || !audioFile.id) {
        await deleteImage(imageId);
        return res.status(400).json({ message: "Audio file is required" });
    }

    if (!imageFile || !imageFile.id) {
        await deleteAudio(audioId);
        return res.status(400).json({ message: "Image file is required" });
    }


    const parseResult = AudioUploadSchema.safeParse(req.body);

    if (!parseResult.success) {
        await deleteAudio(audioId);
        await deleteImage(imageId);

        return res.status(400).json({
            message: "Invalid audio upload data",
            errors: z.treeifyError(parseResult.error),
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
        await deleteAudio(audioId);
        await deleteImage(imageId);

        res.status(500).json({ message: "Internal server error" });
    }

}