import { Router } from "express";
import { multerUpload } from "../../../utils/multer-upload.utils";
import { minioUpload, minioPresignedGet } from "../../../utils/minio.utils";
import { create, get } from "../services/user-info.service";
import { toCamelKeys } from "keys-transform";

const router = Router();

router.post(
  "/",
  multerUpload.fields([{ name: "memberPhoto", maxCount: 1 }]),
  minioUpload,
  async (req, res) => {
    const createdBy = "Admin";
    const { memberPhotoUrl } = req.body;
    const result = await create(req.body);
    res.status(200).json({
      message: "User info route",
      data: result,
    });
  }
);

router.get("/", async (req, res) => {
  const user = await get();
  res.status(201).json({
    message: "Data Serve Sucessfully",
    data: user,
  });
});

export default router;
