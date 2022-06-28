import prologue


import ./views


const urlPatterns* = @[
  pattern("/", home),
  pattern("/", home, HttpPost),
  pattern("/home", home),
  pattern("/login", login),
  pattern("/pool_info", poolInfo),
  pattern("/partial", partial),
  pattern("/farmer", farmer),
  pattern("/multipart", multipart)
]

