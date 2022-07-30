local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js",
	},
}

-- dap.configurations.typescript = {
-- 	{
-- 		name = "Launch",
-- 		type = "node2",
-- 		request = "launch",
-- 		program = "${workspaceFolder}/${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- }

dap.configurations.typescript = {
	{
		name = "ts-node (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "-r", "ts-node/register" },
		runtimeExecutable = "node",
		args = { "--inspect", "${file}" },
		sourceMaps = true,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
	{
		name = "Jest (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
		runtimeExecutable = "node",
		args = { "${file}", "--runInBand", "--coverage", "false" },
		sourceMaps = true,
		port = 9229,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
