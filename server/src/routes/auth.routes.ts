import { Router } from "express";
import { signupController } from "../controllers/auth/signup.controller";
import { loginController } from "../controllers/auth/login.controller";

export const authRouter = Router();

authRouter.post('/signup', signupController);

authRouter.post('/login', loginController);