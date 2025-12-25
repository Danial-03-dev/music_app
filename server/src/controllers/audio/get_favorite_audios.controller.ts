import { Request, Response } from "express";
import { FavoriteAudioModel } from "../../models/favorite_audio.model";

export const getFavoriteAudiosController = async (req: Request, res: Response) => {
    const userId = (req as any).userId;

    try {
        const favoriteAudios = await FavoriteAudioModel.find({ user: userId }).populate('audio');
        return res.status(200).json(favoriteAudios);
    } catch (error) {
        return res.status(500).json({ message: "Failed to retrieve favorite audios" });
    }
};