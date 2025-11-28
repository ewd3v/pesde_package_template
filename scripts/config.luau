return {
	analyzePaths = { "src", "tests", "scripts" }, -- Paths that should have their .luau files analyzed / linted / formatting checked
	buildRuntimes = { "luau" }, -- Runtimes to build and publish for
	testRuntimes = { "luau", "lune" }, -- Runtimes to run tests on
}
