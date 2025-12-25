import { z } from "zod";

export const AudioUploadSchema = z.object({
    name: z.string().min(1, "Name is required"),
    artist: z.string().min(1, "Artist is required"),
    color: z.string().regex(/^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$/, "Invalid color format").optional(),
});

export const FavoriteAudioSchema = z.object({
    id: z.string().min(1, "Audio ID is required"),
});