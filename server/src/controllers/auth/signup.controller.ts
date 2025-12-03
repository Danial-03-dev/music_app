import { Request, Response } from "express";
import { UserCreateSchema } from "../../schemas/user.schemas";
import { z } from "zod";
import { UserModel } from "../../models/user.model";

export const signupController = async (req: Request, res: Response) => {
    const parseResult = UserCreateSchema.safeParse(req.body);

    if (!parseResult.success) {
        return res.status(400).json({
            message: "Invalid request data",
            errors: z.treeifyError(parseResult.error)
        });
    }

    try {
        const { name, email, password } = parseResult.data;

        const existingUser = await UserModel.findOne({ email });

        if (existingUser) {
            return res.status(409).json({ message: "User with this email already exists" });
        }

        const newUser = await UserModel.create({ name, email, password });

        res.status(201).send({
            message: "User created successfully",
            user: newUser
        });
    } catch (error) {
        res.status(500).json({ message: "Internal server error" });
    }
}   