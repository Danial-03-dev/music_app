import { Request, Response } from "express";
import mongoose from "mongoose";
import { validateAudioSignature } from "../../utils/utils";

export const getMediaController = (bucketName: string, isSignedUrl = false) => async (req: Request, res: Response) => {
    const id = req.params.id;


    if (isSignedUrl) {
        const exp = req.query.exp as string | undefined;
        const sig = req.query.sig as string | undefined;
        try {
            validateAudioSignature(id, exp, sig);
        } catch (error) {
            const message = error instanceof Error ? error.message : 'Invalid signature';
            const status = message === 'URL has expired' ? 403 : 401;
            return res.status(status).send(message);
        }
    }

    try {
        const db = mongoose.connection.db;
        if (!db) {
            return res.status(500).json({ message: 'Database not connected' });
        }

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({ message: 'Invalid file ID' });
        }

        const fileId = new mongoose.Types.ObjectId(id);

        const files = await db.collection(`${bucketName}.files`).find({ _id: fileId }).toArray();

        if (!files || files.length === 0) {
            return res.status(404).json({ message: 'File not found' });
        }

        const file = files[0];
        const fileSize = file.length;
        const range = req.headers.range;

        const bucket = new mongoose.mongo.GridFSBucket(db, { bucketName });

        if (!range) {
            res.set({
                'Content-Type': file.contentType || 'application/octet-stream',
                'Content-Length': fileSize,
                'Cache-Control': 'no-cache',
                'Accept-Ranges': 'bytes',
            });


            const downloadStream = bucket.openDownloadStream(fileId);

            downloadStream.on('error', (err) => {
                console.error("Error downloading file:", err);
                res.status(500).json({ message: 'Error downloading file' });
            });

            downloadStream.pipe(res);
            return;
        }

        const [startStr, endStr] = range.replace(/bytes=/, "").split("-");
        const start = parseInt(startStr, 10);
        const end = endStr ? parseInt(endStr, 10) : fileSize - 1;

        if (start >= fileSize) {
            return res.sendStatus(416);
        }

        const chunkSize = end - start + 1;

        res.writeHead(206, {
            "Content-Range": `bytes ${start}-${end}/${fileSize}`,
            "Accept-Ranges": "bytes",
            "Content-Length": chunkSize,
            "Content-Type": file.contentType || 'application/octet-stream',
            'Cache-Control': 'no-cache',
        });

        const downloadStream = bucket.openDownloadStream(fileId, { start, end: end + 1 });

        downloadStream.on('error', (err) => {
            console.error("Error downloading file:", err);
            res.status(500).json({ message: 'Error downloading file' });
        });

        downloadStream.pipe(res);
    } catch (error) {
        console.error("Error retrieving file:", error);
        res.status(500).json({ message: 'Internal server error' });
    }
};