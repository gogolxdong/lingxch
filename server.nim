import htmlgen
import jester
import json


settings:
    bindAddr = "127.0.0.1"
    port = Port(8080)

routes:
    get "/":
        resp h1("Hello world")
    get "/pool_info":
        var poolInfo = %* {
            "authentication_token_timeout": 5,
            "description": "xch pool reinforced by distributed storage technique lingx",
            "fee": "0.0",
            "logo_url": "https://xchpool.org/wp-content/uploads/XCHPool.png",
            "minimum_difficulty": 1,
            "name": "lingxch",
            "protocol_version": 1,
            "relative_lock_height": 64,
            "target_puzzle_hash": "0xf44fe0789562bfcf4915e0d0eea1c61cb75cee537ed392c2f371a86a8df9123f"
        }
        echo $poolInfo
        resp($poolInfo, contentType = "text/json;charset=utf-8")
    post "/partial":
        echo request.body
        resp($ %*{"new_difficulty": 1})
    post "/farmer":
        echo request.body
        resp($ %*{"authentication_public_key":"","payout_instructions":"","current_difficulty":1, "current_points": 1})
