import { Request, Response } from "express";
import z from "zod";
import { deleteAudio } from "../../file_transfer/upload/delete_audio";
import { deleteImage } from "../../file_transfer/upload/delete_image";
import { AudioDeleteSchema } from "../../schemas/audio.schemas";
import { AudioModel } from "../../models/audio.model";

export const deleteAudioController = async (req: Request, res: Response) => {
    const parseResult = AudioDeleteSchema.safeParse(req.body);

    if (!parseResult.success) {

        return res.status(400).json({
            message: "Invalid audio delete data",
            errors: z.treeifyError(parseResult.error),
        });
    }

    const { _id, audioId, imageId } = parseResult.data;

    try {
        await deleteAudio(audioId);
        await deleteImage(imageId);

        const deletedAudio = await AudioModel.findByIdAndDelete(_id);

        if (!deletedAudio) {
            return res.status(404).json({ message: "Audio not found" });
        }

        return res.status(200).json({ message: "Audio deleted successfully", deletedAudio });
    } catch (error) {
        return res.status(500).json({ message: "Internal server error" });
    }
};