import { Request, Response } from "express";
import mongoose from "mongoose";


export const getMediaController = (bucketName: string) => async (req: Request, res: Response) => {
    try {
        const db = mongoose.connection.db;
        if (!db) {
            return res.status(500).json({ message: 'Database not connected' });
        }

        if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
            return res.status(400).json({ message: 'Invalid file ID' });
        }

        const fileId = new mongoose.Types.ObjectId(req.params.id);

        const files = await db.collection(`${bucketName}.files`).find({ _id: fileId }).toArray();

        if (!files || files.length === 0) {
            return res.status(404).json({ message: 'File not found' });
        }

        const file = files[0];

        res.set({
            'Content-Type': file.contentType || 'application/octet-stream',
            'Content-Length': file.length,
            'Content-Disposition': 'inline',
            'Cache-Control': 'public, max-age=31536000, immutable',
        });

        const bucket = new mongoose.mongo.GridFSBucket(db, { bucketName });
        const downloadStream = bucket.openDownloadStream(fileId);

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