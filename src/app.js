import express from "express";
import cors from "cors";
import * as path from "path";
import { getPort, minioBucketName } from "./configs/app.config";
// import { pgConnect } from "./db/factory/connection.db";
import { createBucket } from "./db/minio.db";

// const coopModule = require("./modules/coop");

const app = express();

app.use(cors());

// coopModule.init(app);

const PORT = getPort();

//connection
// await pgConnect.getConnection("master");
// await pgConnect.getConnection("slave");

await createBucket(minioBucketName);

// const app = await appFactory();
app.listen(PORT, () => console.log(`[INFO] Listening on port ${PORT}`));
