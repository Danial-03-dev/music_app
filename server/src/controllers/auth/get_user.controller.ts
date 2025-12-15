import { Request, Response } from "express";
import { UserModel } from "../../models/user.model";

export const getUserController = async (req: Request, res: Response) => {
    try {
        const userId = (req as any)?.userId;

        if (!userId) {
            return res.status(400).json({ message: "User ID not provided" });
        }

        const user = await UserModel.findById(userId)

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        return res.status(200).json({ user });
    } catch (error) {
        return res.status(500).json({ message: "Internal server error" });
    }
};