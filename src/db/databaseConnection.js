import pkg from "pg";
import { appConf } from "../configs/app.config";

const { Pool } = pkg;

class ConnectionFactory {
  constructor() {}
  async connect() {
    const pool = new Pool({ ...appConf.db });
    try {
      await pool.connect();
      console.log("[INFO] connected to Database");
    } catch (error) {
      console.log(error);
    }
    return pool;
  }

  async getConnection() {
    try {
      return await this.connect();
    } catch (error) {
      throw new Error("connection credentials is not valid");
    }
  }
}

export const pgConnect = new ConnectionFactory();
