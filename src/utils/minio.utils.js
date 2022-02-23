import { minioClient } from "../db/minio.db";
import path from "path";
import { minioBucketName } from "../configs/app.config";
// import _, { get, isArray, set } from "lodash";
import { getPaths } from "./json-path.utils";

import pkg from "lodash";
const { _, get, isArray, set } = pkg;

export const minioUpload = async (req, res, next) => {
  if (typeof req.files === "object") {
    const files = {};
    const fieldNames = Object.keys(req.files);
    for await (const fieldName of fieldNames) {
      const file = req.files[fieldName][0];
      const fileName = `${file.fieldname}-${Date.now()}${path.extname(
        file.originalname
      )}`;

      await minioClient.putObject(minioBucketName, fileName, file.buffer);

      const url = await minioClient.presignedGetObject(
        minioBucketName,
        fileName
      );

      files[fieldName] = fileName;
      files[fieldName + "Url"] = url;
    }
    req.body = { ...req.body, ...files };
  }

  next();
};

const getUrl = async (value) => {
  return value
    ? await minioClient.presignedGetObject(minioBucketName, value)
    : null;
};

export const minioPresignedGet = async (objects, keys) => {
  let obj;

  const paths = getPaths(objects, keys);

  for await (const p of paths) {
    const value = get(objects, p);
    const url = await getUrl(value);

    const path = p + "Url";

    obj = _.set(objects, path, url);
  }

  return obj;
};

export const minioObjectDelete = async (object, keys) => {
  keys.map(async (key) => {
    if (object[key]) {
      await minioClient.removeObject(minioBucketName, object[key]);
      object[key] = null;
    }
  });

  return object;
};
