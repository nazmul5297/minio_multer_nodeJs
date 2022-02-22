import express from "express";
import cors from "cors";
import * as path from "path";
import { getPort, minioBucketName } from "./configs/app.config";
import { pgConnect } from "./db/databaseConnection";
import { createBucket } from "./db/minio.db";
import * as userModule from "./modules/user";

const app = express();

app.use(cors());

userModule.init(app);

const PORT = getPort();

//database connection
await pgConnect.getConnection();

await createBucket(minioBucketName);

// const app = await appFactory();
app.listen(PORT, () => console.log(`[INFO] Listening on port ${PORT}`));
