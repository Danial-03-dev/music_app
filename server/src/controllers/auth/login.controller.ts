import { Request, Response } from "express";
import { UserLoginSchema } from "../../schemas/user.schemas";
import { z } from "zod";
import { UserModel } from "../../models/user.model";
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

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

        const token = jwt.sign(
            { userId: user._id },
            process.env.JWT_SECRET || "music_app_secret_key_12345",
            { expiresIn: '3d' }
        );

        return res.status(200).json({
            message: "Login successful",
            user,
            token,
        });
    } catch (error) {
        res.status(500).json({ message: "Internal server error" });
    }
};