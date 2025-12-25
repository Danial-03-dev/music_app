import mongoose from "mongoose";

export interface FavoriteAudioInterface {
    user: mongoose.Types.ObjectId;
    audio: mongoose.Types.ObjectId;
    createdAt: Date;
    updatedAt: Date;
}

const FavoriteAudioSchema = new mongoose.Schema<FavoriteAudioInterface>(
    {
        user: { type: mongoose.Schema.Types.ObjectId, required: true, ref: "User" },
        audio: { type: mongoose.Schema.Types.ObjectId, required: true, ref: "Audio" },
    },
    { timestamps: true }
);

export const FavoriteAudioModel = mongoose.model<FavoriteAudioInterface>("FavoriteAudio", FavoriteAudioSchema);