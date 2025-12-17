import { model, Schema, Types } from "mongoose";


export interface AudioInterface {
    name: string;
    artist: string;
    color: string;
    audioId: Types.ObjectId;
    imageId: Types.ObjectId;
    mimeType: string;
    size: number;
    createdAt: Date;
    updatedAt: Date;
}

const AudioSchema = new Schema<AudioInterface>({
    name: { type: String, required: true },
    artist: { type: String, required: true },
    color: { type: String, required: true, match: /^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$/ },
    audioId: { type: Schema.Types.ObjectId, required: true },
    imageId: { type: Schema.Types.ObjectId, required: true },
    mimeType: { type: String, required: true },
    size: { type: Number, required: true },
}, { timestamps: true });

export const AudioModel = model<AudioInterface>("Audio", AudioSchema);