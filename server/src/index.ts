import express, { Request, Response } from "express";

const app = express();

app.use(express.json());

const PORT = process.env.port || 3000;

app.post('signup', (req: Request<{}, {}, UserCreate>, res: Response) => {
    const { name, email, password } = req.body;

    // Here you would typically handle user creation logic, e.g., saving to a database
    res.status(201).send({
        message: "User created successfully",
        user: { name, email }
    });
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});


interface UserCreate {
    name: string;
    email: string;
    password: string;
}