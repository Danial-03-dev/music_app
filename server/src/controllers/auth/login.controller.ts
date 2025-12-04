import { Request, Response } from "express";
import { UserLoginSchema } from "../../schemas/user.schemas";
import { z } from "zod";
import { UserModel } from "../../models/user.model";
import bcrypt from 'bcryptjs';

export const loginController = async (req: Request, res: Response) => {
    const parseResult = UserLoginSchema.safeParse(req.body);

    if (!parseResult.success) {
        return res.status(400).json({
            message: "Invalid request data",
            errors: z.treeifyError(parseResult.error),
        })
    }

    try {
        const { email, password } = parseResult.data;

        const user = await UserModel.findOne({ email });

        if (!user) {
            return res.status(401).json({ message: "Invalid email" });
        }

        const isPasswordValid = await bcrypt.compare(password, user.password);

        if (!isPasswordValid) {
            return res.status(401).json({ message: "Invalid password" });
        }

        return res.status(200).json({
            message: "Login successful",
            user,
        });
    } catch (error) {
        res.status(500).json({ message: "Internal server error" });
    }
};