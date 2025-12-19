import { Request, Response } from "express";
import { signAudioUrl } from "../../utils/utils";

export const getAudioSignedUrlController = (req: Request, res: Response) => {
    const audioId = req.params.id;

    const url = signAudioUrl(audioId, 60);
    res.send(url);
}