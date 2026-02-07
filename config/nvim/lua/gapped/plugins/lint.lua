MiniDeps.add({ source = "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")
lint.linters_by_ft = {
	python = { "mypy", "pylint" },
}

_G.Config.new_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, "*", function()
	if vim.bo.modifiable then
		lint.try_lint()
	end
end, "Lint File")
