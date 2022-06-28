import prologue
import prologue/middlewares/staticfile
import prologue/middlewares/utils
from prologue/openapi import serveDocs

import views, urls

let
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "lingxch"),
                         debug = env.getOrDefault("debug", true),
                         address = env.getOrDefault("address", "0.0.0.0"),
                         port = Port(env.getOrDefault("port", 80)),
                         
    )

proc setLoggingLevel() =
  discard
  # addHandler(newConsoleLogger())
  # logging.setLogFilter(lvlInfo)

let
  event = initEvent(setLoggingLevel)
var
  app = newApp(settings = settings, startup = @[event])

app.addRoute("/", home, HttpGet)
app.addRoute("/", home, HttpPost)
app.addRoute("/pool_info", poolInfo, HttpGet)
app.addRoute("/partial", partial, HttpPost)
app.addRoute("/farmer", farmer, HttpPost)
app.addRoute("/farmer", farmer, HttpPut)

app.run()

