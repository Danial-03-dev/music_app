import { Router } from "express";
import { signupController } from "../controllers/auth/signup.controller";
import { loginController } from "../controllers/auth/login.controller";
import { authMiddleware } from "../middleware/auth.middleware";
import { getUserController } from "../controllers/auth/get_user.controller";

export const authRouter = Router();

authRouter.post('/signup', signupController);
authRouter.post('/login', loginController);
authRouter.get('/', authMiddleware, getUserController);
