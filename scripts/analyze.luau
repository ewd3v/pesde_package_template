local config = require("./config")
local process = require("@lune/process")

process.exec("lune", { "setup" }, {
	cwd = "scripts",
})

local selene = process.exec("selene", { "--no-summary", unpack(config.analyzePaths) }, {
	stdio = "forward",
})
local luau_lsp = process.exec(
	"luau-lsp",
	{ "analyze", "--platform=standard", "--settings=.vscode/settings.json", unpack(config.analyzePaths) },
	{
		stdio = "forward",
	}
)

if selene.ok == false then
	process.exit(selene.code)
end
if luau_lsp.ok == false then
	process.exit(luau_lsp.code)
end
