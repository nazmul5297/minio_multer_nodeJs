import multer from "multer";

export const multerUpload = multer({
  limits: {
    fileSize: 5000000, //5MB
  },
  fileFilter: (req, file, cb) => {
    if (
      file.mimetype === "image/jpg" ||
      file.mimetype === "image/png" ||
      file.mimetype === "image/jpeg"
    ) {
      cb(null, true);
    } else {
      cb(new Error("Only .jpg, .png, .jpeg format allowed!"), false);
    }
  },
});
