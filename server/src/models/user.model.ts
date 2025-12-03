import mongoose, { Document, Schema, } from "mongoose";
import bcrypt from "bcryptjs";


export interface UserDocument extends Document {
    name: string;
    email: string;
    password: string;
}

const UserSchema = new Schema<UserDocument>({
    name: { type: String, required: true, maxLength: 100 },
    email: { type: String, required: true, unique: true, maxLength: 100 },
    password: { type: String, required: true },
},
    { timestamps: true }
);

UserSchema.pre<UserDocument>("save", async function (this: UserDocument,) {
    if (!this.isModified("password")) return; // only hash if password changed

    const saltRounds = 10;
    this.password = await bcrypt.hash(this.password, saltRounds);
});

export const UserModel = mongoose.model<UserDocument>("User", UserSchema);