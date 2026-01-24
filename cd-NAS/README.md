### cd-NAS

1. Place `repos.bat` and `repos.ps1` `inside C:\Sukurtas\cd-NAS` (any path will do
as long as both files are in the same folder).

2. Add environment variables `NAS2_USER` and `NAS2_PASSWORD`
```
setx NAS2_USER "<username>" /M
```

```
setx NAS2_PASSWORD "<password>" /M
```

3. Add `inside C:\Sukurtas\cd-NAS` to %PATH%. Restart terminal.

4. Type "repos" in the cmd.


##### How it works ?
When `repos` is executed in cmd, windows searches for executable file named `repos.exe`
or `repos.bat` (or so) in the %PATH% list).

##### Future improvements
Encrypt environment variables (`NAS2_USER` and `NAS2_PASSWORD`),
because now they are stored in the plain text.
