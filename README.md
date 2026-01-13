# Run in command line
```bash
brew install neovim git ripgrep fd node python go && rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && git clone --depth 1 https://github.com/mariothedev/neovim-config.git ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim --headless "+Lazy! sync" "+MasonInstall pyright html-lsp css-lsp typescript-language-server gopls eslint-lsp" "+qa"
```
