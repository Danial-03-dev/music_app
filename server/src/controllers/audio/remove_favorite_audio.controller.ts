import { Request, Response } from "express";
import { FavoriteAudioSchema } from "../../schemas/audio.schemas";
import z from "zod";
import { FavoriteAudioModel } from "../../models/favorite_audio.model";

export const removeFavoriteAudioController = async (req: Request, res: Response) => {
    const parsedResult = FavoriteAudioSchema.safeParse(req.body);

    if (!parsedResult.success) {
        return res.status(400).json({
            message: "Invalid request data",
            error: z.treeifyError(parsedResult.error)
        });
    }

    const userId = (req as any).userId;
    const { id } = parsedResult.data;

    try {
        const removedAudio = await FavoriteAudioModel.deleteOne({
            user: userId,
            audio: id,
        });

        if (removedAudio.deletedCount === 0) {
            return res.status(404).json({ message: "Audio is not in favorites" });
        }

        return res.status(200).json({ message: "Favorite audio removed successfully", removedAudio });
    } catch (error) {
        return res.status(500).json({ message: "Failed to remove favorite audio" });
    }
};