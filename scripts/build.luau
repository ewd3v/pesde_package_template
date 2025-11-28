local config = require("./config")
local process = require("@lune/process")

local runtimeFlags = {}
for _, runtime in config.buildRuntimes do
	table.insert(runtimeFlags, `--{runtime}`)
end

local multitarget = process.exec("multitarget", {
	"build",
	"--yes",
	"--build-files",
	"src",
	"--output",
	"dist",
	"--global",
	"RUNTIME",
	"--require-mode",
	"luau",
	unpack(runtimeFlags),
}, {
	stdio = "forward",
})
process.exit(multitarget.code)
