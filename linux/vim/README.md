# VIM

```
if [[ ! -f "$HOME/.vimrc" ]]
then
  curl -so $HOME/.vimrc https://raw.githubusercontent.com/mmmarceleza/devops/main/linux/vim/.vimrc
else
  echo "You already have a .vimrc file"
fi
  
```
