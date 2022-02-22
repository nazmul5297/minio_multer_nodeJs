import fs from "fs";
import path from "path";

const configPath = path.resolve() + "/appconfig.json";

export const appConf = JSON.parse(fs.readFileSync(configPath, "utf-8"));

export function getPort() {
  return Number(appConf.port) || 5000;
}

//minio
export const minioSecretKey = appConf.minio.secretKey;
export const minioEndPoint = appConf.minio.endPoint;
export const minioPort = appConf.minio.port;
export const minioAccessKey = appConf.minio.accessKey;

export const minioBucketName = appConf.minio.bucketName;
