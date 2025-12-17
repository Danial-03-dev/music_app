import { Types } from "mongoose";

export interface GridFsFile extends Express.Multer.File {
    id: Types.ObjectId | any;
    bucketName: string;
    contentType: string;
}
