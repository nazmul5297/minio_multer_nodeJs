import { Client } from "minio";
import {
  minioAccessKey,
  minioEndPoint,
  minioPort,
  minioSecretKey,
} from "../configs/app.config";

export const minioClient = new Client({
  endPoint: minioEndPoint,
  port: minioPort,
  useSSL: false,
  accessKey: minioAccessKey,
  secretKey: minioSecretKey,
});

export const createBucket = async (bucket) => {
  const existingBucket = await minioClient.bucketExists(bucket);

  existingBucket || (await minioClient.makeBucket(bucket, "us-east-1"));

  console.log(`[INFO] Connected to Minio`);
};
