const express = require("express");
const bodyParser = require("body-parser");
const Joi = require("@hapi/joi");
const app = express();
const db = require("./db");
app.use(express.json());
app.get("/posts", function(req, res) {
  db.getAllPosts().then(result => res.json(result));
});

app.post("/post", (req, res) => {
  const schema = Joi.object({
    title: Joi.string()
      .min(3)
      .max(30)
      .required(),

    body: Joi.string()
      .min(3)
      .required()
  });
  const error = schema.validate(req.body).error;

  if (error) {
    res.status(400);
    res.send(error);
  } else {
    db.createPost(req.body.title, req.body.body)
      .then(result => res.status(201) && res.json(result))
      .catch(error => res.status(400) && res.send(error));
  }
});

app.listen(3000);
console.log("Listening on port 3000...");
