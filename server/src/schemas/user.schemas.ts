import { z } from "zod";

export const UserCreateSchema = z.object({
    name: z.string().min(1),
    email: z.email(),
    password: z.string().min(6),
});

export type UserCreateSchemaType = z.infer<typeof UserCreateSchema>;