local config = require("./config")
local process = require("@lune/process")

local stylua = process.exec("stylua", { "--check", unpack(config.analyzePaths) }, {
	stdio = "forward",
})
process.exit(stylua.code)
