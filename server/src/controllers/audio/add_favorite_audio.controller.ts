import { Request, Response } from "express";
import { FavoriteAudioSchema } from "../../schemas/audio.schemas";
import { z } from "zod";
import { FavoriteAudioModel } from "../../models/favorite_audio.model";

export const addFavoriteAudioController = async (req: Request, res: Response) => {
    const parsedResult = FavoriteAudioSchema.safeParse(req.body);

    if (!parsedResult.success) {
        return res.status(400).json({
            message: "Invalid request data",
            error: z.treeifyError(parsedResult.error)
        });
    }

    const userId = (req as any).userId;
    const { id } = parsedResult.data;

    const audioData = { user: userId, audio: id };

    try {
        const existingFavorite = await FavoriteAudioModel.findOne(audioData);
        if (existingFavorite) {
            return res.status(409).json({ message: "Audio is already in favorites", existingFavorite });
        }

        const favoriteAudio = await FavoriteAudioModel.create(audioData);

        return res.status(201).json({ message: "Favorite audio added successfully", favoriteAudio });
    } catch (error) {
        return res.status(500).json({ message: "Failed to add favorite audio" });
    }
};

