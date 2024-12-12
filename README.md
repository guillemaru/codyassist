# CodyAssist

CodyAssist is a convenient wrapper around the [Cody CLI](https://sourcegraph.com/docs/cody/clients/install-cli), making it easier to interact with Cody from within Neovim.

## Features

- Ask Cody a question using the current file as context
- Ask Cody a question using the current file as context and the selected text in Visual mode
- Set a context repo to be included in the context used by Cody for the answer
- Enjoy an answer with code highlights
- Toggle the window that contains the answer

## Installation

This assumes you followed the Cody CLI instructions to get authenticated.

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your `init.lua` or equivalent configuration file:

```lua
{
    "guillemaru/codyassist",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("codyassist").setup()
		vim.keymap.set("v", "<leader>cq", function()
			local variable = {}
			variable.args = "Explain this code:"
			require("codyassist").QuestionWithSelection(variable)
		end, { noremap = true, silent = true, desc = "Ask Cody about selection" })
		vim.keymap.set("n", "<leader>ce", function()
			require("codyassist").EnableRepo()
		end, { noremap = true, silent = true, desc = "Enable using Cody context repo" })
		vim.keymap.set("n", "<leader>cd", function()
			require("codyassist").DisableRepo()
		end, { noremap = true, silent = true, desc = "Disable using Cody context repo" })
		vim.keymap.set("n", "<leader>ct", function()
			require("codyassist").ToggleChatWindow()
		end, { noremap = true, silent = true, desc = "Toggle window with Cody's answer" })
	end,
}
```

## Recommended Key Mappings

- `<leader>cq`: Ask Cody about the selected text (in Visual mode)
- `<leader>ce`: Enable using context repo
- `<leader>cd`: Disable using context repo
- `<leader>ct`: Toggle window with Cody's answer

These key mappings are designed to enhance your workflow by providing quick access to common commands. Feel free to customize them to your liking.

## Functions
CodyQuestion to ask a question. It will use the current buffer as context file.
CodyAssist to ask a question about the selection (Visual mode). It will use the current buffer as context file.
CodyRepo <repo> to set a repository for the context. Without arguments, the function will print the current selected repository, if any.
CodyRepoEnable will enable using context repo for questions (false by default).
CodyRepoDisable will disable using context repo for questions.
CodyToggleWin will toggle the chat window that contains the question/response.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.

