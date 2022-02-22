// import "reflect-metadata";
// import * as http from "http";
// import express, { Application } from "express";
// import { json, urlencoded } from "body-parser";
// import * as path from "path";
// import cors from "cors";
// import fs from "fs";
// import morgan from "morgan";
// import { errorHandler } from "./middlewares/error-handler.middle";
// import { messageBangla } from "./interceptors/bangla-message.interceptor";

// // importing modules
// import * as coopModule from "./modules/coop";
// import * as userModule from "./modules/user";
// import * as roleModule from "./modules/role";
// import * as citizenModule from "./modules/citizen";
// import * as masterModule from "./modules/master";

// export default async function appFactory() {
//   // express app init
//   const app = express();

//   // enabling cors
//   app.use(cors());

//   // body parser config
//   const jsonParser = json({
//     inflate: true,
//     limit: "10mb",
//     type: "application/json",
//     verify: (req, res, buf, encoding) => {
//       // place for sniffing raw request
//       return true;
//     },
//   });

//   // using json parser and urlencoder
//   app.use(jsonParser);
//   app.use(urlencoded({ extended: true }));

//   // enabling loggin of HTTP request using morgan
//   // create a write stream (in append mode)
//   const accessLogStream = fs.createWriteStream(
//     path.join(__dirname, "access.log"),
//     { flags: "a" }
//   );
//   // setup the logger
//   app.use(morgan("combined", { stream: accessLogStream }));

//   // for handling uncaught exception from application
//   process.on("uncaughtException", (err) => {
//     console.error("[ERROR] Uncaught Exception : ", err.message);
//     process.exit(1);
//   });

//   process.on("unhandledRejection", (error) => {
//     console.error("[ERROR] From event: ", error?.toString());
//     process.exit(1);
//   });

//   /**
//    * Register Modules
//    */
//   coopModule.init(app);
//   userModule.init(app);
//   roleModule.init(app);
//   citizenModule.init(app);
//   masterModule.init(app);

//   /**
//    * Register Error Handler
//    */
//   app.use(errorHandler);

//   return app;
// }

import express from "express";
import cors from "cors";
import * as path from "path";
import { json, urlencoded } from "body-parser";
import * as fs from "fs";
import morgan from "morgan";
import * as http from "http";
import userModule from "./modules/coop";
import { getPort, minioBucketName } from "./configs/app.config";
// import { pgConnect } from "./db/factory/connection.db";
import { createBucket } from "./db/minio.db";

const app = express();

app.use(cors());

coopModule.init(app);

const PORT = getPort();

//connection
// await pgConnect.getConnection("master");
// await pgConnect.getConnection("slave");

await createBucket(minioBucketName);

// const app = await appFactory();
app.listen(PORT, () => console.log(`[INFO] Listening on port ${PORT}`));
