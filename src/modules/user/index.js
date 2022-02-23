import userInfoRoute from "./routes/user-info.route";

export function init(app) {
  app.use("/user", userInfoRoute);
}
