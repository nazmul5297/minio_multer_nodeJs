import buildInsertSql from "../../../utils/sqlBuilders";
import pkg from "lodash";
const { _, isArray } = pkg;
import { pgConnect } from "../../../db/databaseConnection";
import { toCamelKeys } from "keys-transform";

export const create = async (body) => {
  const convertData = _.omit(body, ["memberPhoto"]);
  convertData.created_by = "Admin";
  const { sql, params } = buildInsertSql("user_info", convertData);

  const result = (await (await pgConnect.getConnection()).query(sql, params))
    .rows;

  return result ? toCamelKeys(result) : {};
};

export const get = async () => {
  const result = (
    await (await pgConnect.getConnection()).query("SELECT * FROM user_info")
  ).rows[0];

  return result ? result : {};
};
