const sqlite3 = require("sqlite3").verbose();
const db = new sqlite3.Database("./db/blog.db", sqlite3.OPEN_READWRITE);

const selectAllPostsQuery = "SELECT * FROM posts;";

const insertPostQuery = () => `INSERT INTO posts (title,body) VALUES(?,?)`;

const getAllPosts = () =>
  new Promise((resolve, reject) =>
    db.all(selectAllPostsQuery, (err, result) =>
      err ? console.log(err) && reject(err) : resolve(result)
    )
  );

const createPost = (title, body) =>
  new Promise((resolve, reject) =>
    db.get(insertPostQuery(), [title, body], (err, result) =>
      err ? console.log(err) && reject(err) : resolve(result)
    )
  );

module.exports = {
  getAllPosts,
  createPost
};
