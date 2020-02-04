const sqlite3 = require("sqlite3").verbose();
const db = new sqlite3.Database("./db/blog.db", sqlite3.OPEN_READWRITE);

const selectAllPostsQuery = "SELECT * FROM posts;";

const getAllPosts = () =>
  new Promise((resolve, reject) =>
    db.all(selectAllPostsQuery, (err, result) =>
      err ? reject(err) : resolve(result)
    )
  );

const createPost = () => {};

module.exports = {
  getAllPosts
};
