import { Request, Response } from "express";
import { AudioModel } from "../../models/audio.model";

export const getAudioListController = async (_req: Request, res: Response) => {
    try {
        const audioList = await AudioModel.find();
        return res.status(200).json(audioList);
    } catch (error) {
        return res.status(500).json({ message: "Internal server error" });
    }
};