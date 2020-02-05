const app = require("./server"); // Link to your server file
const supertest = require("supertest");
const request = supertest(app);

it("gets the posts endpoint", async done => {
  const response = await request.get("/posts");

  expect(response.status).toBe(200);
  expect(response.body).toEqual(
    expect.arrayContaining([{ post_id: 1, title: "hai", body: "hai" }])
  );
  done();
});

describe("POST /post", () => {
  const blogPost = { title: "This is the title", body: "This is the body" };
  it("inserts a new post", async done => {
    const response = await request
      .post("/post")
      .send(blogPost)
      .set("Accept", "application/json");

    expect(response.status).toBe(201);
    done();
  });

  it("get /posts includes new post", async done => {
    const response = await request.get("/posts");

    expect(response.status).toBe(200);
    expect(response.body).toEqual(expect.arrayContaining([
      Object.assign({}, { post_id: expect.anything() }, blogPost)
    ]))
    done();
  });
});
