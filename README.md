1. Update macOS to the latest version through system preferences
2. Setup an SSH key and properly format the ssh config file via

   ```zsh
   curl https://raw.githubusercontent.com/MarkAureli/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"
   ```

3. Clone this repo to `~/.dotfiles` with:

    ```zsh
    git clone --recursive git@github.com:MarkAureli/dotfiles.git ~/.dotfiles
    ```

4. Run the installation with:

    ```zsh
    cd ~/.dotfiles && ./fresh.sh
    ```
