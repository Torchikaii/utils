### Git credentials

### Storing tokens

1. Setup Git to remember your credentials
```
git config --global credential.helper store
```

2. Pull private repo
```
git pull https://github.com/Torchikaii/utils.git
```

3. Enter credentials (username and token)

4. Verify tokens were added
```
cat ~/.git-credentials
```
