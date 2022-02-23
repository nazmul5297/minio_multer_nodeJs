// import _, { isArray } from "lodash";

import pkg from "lodash";
const { _, isArray } = pkg;

function mapper(thing, prefix, paths) {
  if (_.isObject(thing)) {
    _.forEach(thing, function (value, key) {
      mapper(value, prefix + key + ".", paths);
    });
  } else if (_.isArray(thing)) {
    for (var i = 0; i < thing.length; i++)
      mapper(value, prefix + i + ".", paths);
  } else {
    paths.push(prefix.replace(/\.$/, ""));
  }
}

const getPathHelper = (obj, query, paths) => {
  const reg = new RegExp(query.replace(/\[\]/g, "\\d"));

  mapper(obj, "", paths);

  return _.filter(paths, function (v) {
    return reg.test(v);
  });
};

/**
 * @param  {object[]|object} obj
 * @param [} query
 */
export const getPaths = (obj, query) => {
  const results = [];
  if (!isArray(query)) {
    results.push(...getPathHelper(obj, query, []));
  } else {
    query.forEach((q) => {
      results.push(...getPathHelper(obj, q, []));
    });
  }

  return results;
};
