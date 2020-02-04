const express = require("express");
const app = express();
const db = require("./db");

app.get("/posts", function(req, res) {
  db.getAllPosts().then(result => res.json(result));
});

app.post("/post", (req, res) => {});

app.listen(3000);
console.log("Listening on port 3000...");
