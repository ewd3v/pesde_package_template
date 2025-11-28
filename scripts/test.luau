local config = require("./config")
local process = require("@lune/process")

local runtimeFlags = {}
for _, runtime in config.testRuntimes do
	table.insert(runtimeFlags, `--{runtime}`)
end

local multitarget = process.exec("pesde", {
	"x",
	"ewdev/multitarget",
	"--",
	"build",
	"--yes",
	"--build-files",
	"src",
	"tests",
	"--output",
	"dist_test",
	"--global",
	"RUNTIME",
	"--require-mode",
	"luau",
	unpack(runtimeFlags),
}, {
	stdio = "forward",
})

if multitarget.ok == false then
	process.exit(multitarget.code)
end

local results = {}
local sep = string.rep("-", 10)

if table.find(config.testRuntimes, "luau") then
	print(`{sep}\nRunning luau tests...`)
	table.insert(
		results,
		process.exec("luau", { "tests/init.luau" }, {
			cwd = "dist_test/luau",
			stdio = "forward",
		})
	)
	print(sep)
end

if table.find(config.testRuntimes, "lune") then
	print(`{sep}\nRunning Lune tests...`)
	table.insert(
		results,
		process.exec("lune", { "run", "tests/init.luau" }, {
			cwd = "dist_test/lune",
			stdio = "forward",
		})
	)
	print(sep)
end

if table.find(config.testRuntimes, "roblox") then
	print(`{sep}\nRunning Roblox tests...`)
	do
		print("Tests currently don't run on Roblox")
		table.insert(results, {
			ok = false,
			code = 1,
			stdout = "",
			stderr = "",
		})
	end
	print(sep)
end

for _, result in results do
	if result.ok == false then
		process.exit(result.code)
	end
end

print("All runtime tests finished without any issues!")
