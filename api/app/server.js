const express = require("express");
const bodyParser = require("body-parser");
const Joi = require("@hapi/joi");
const app = express();
const db = require("./db");
app.use(express.json());
app.get("/posts", function(req, res) {
  db.getAllPosts().then(result => res.json(result));
});

app.post("/post", ({ body = {} }, res) => {
  const schema = Joi.object({
    title: Joi.string()
      .min(3)
      .max(30)
      .required(),

    body: Joi.string()
      .min(3)
      .required()
  });
  const error = schema.validate(body).error;

  if (error) {
    res.status(400);
    res.send(error);
  } else {
    db.createPost(body.title, body.body)
      .then(result => res.status(201) && res.json(result))
      .catch(error => res.status(400) && res.send(error));
  }
});

module.export = app;
