import prologue
import std/[tables, logging]
import json
import blscurve

proc articles*(ctx: Context) {.async.} =
  resp $ctx.getPathParams("num", 1)

proc hello*(ctx: Context) {.async.} =
  # await sleepAsync(3000)
  resp "<h1>Hello, Prologue!</h1>"
  if true:
    raise newException(ValueError, "can't be reached")

proc index*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("index.html", "static")

proc helloName*(ctx: Context) {.async.} =
  logging.debug ctx.getPathParams("name")
  resp "<h1>Hello, " & ctx.getPathParams("name", "World") & "</h1>"

proc home*(ctx: Context) {.async.} =
  logging.debug urlFor(ctx, "index")
  logging.debug urlFor(ctx, "helloname", {"name": "my friend"}, {"age": "20"})
  logging.debug ctx.request.queryParams.getOrDefault("name", "")
  resp redirect(urlFor(ctx, "helloname", {"name": "my friend"}, {"age": "20", "hobby": "Nim"}), Http302)

proc login*(ctx: Context) {.async.} =
  resp loginPage()

proc poolInfo*(ctx: Context) {.async.} =
  ctx.response.setHeader("Content-Type","text/json; charset=UTF-8")
  resp readFile("pool_info")

proc partial*(ctx: Context) {.async.} =
  resp($ %*{"new_difficulty": 1})

type FarmerInfo = object
  authentication_public_key: string
  payout_instructions: string
  current_difficulty: uint64
  current_points: uint64

var farmerTable: Table[string, FarmerInfo]
proc farmer*(ctx: Context) {.async.} =
  echo ctx.request.body
  resp($ %*{"authentication_public_key":"","payout_instructions":"","current_difficulty":1, "current_points": 1})


proc multiPart*(ctx: Context) {.async.} =
  resp multiPartPage()

proc do_multiPart*(ctx: Context) {.async.} =
  logging.debug ctx.request.formParams["username"].body
  logging.debug ctx.request.formParams["password"].body
  resp redirect("/login")

proc upload*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("upload.html", "static")

proc do_upload*(ctx: Context) {.async.} =
  logging.debug ctx.request.formParams
  resp ctx.request.formParams["file"].body



