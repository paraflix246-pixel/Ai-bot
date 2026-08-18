# Windows: clone and start the bot

`C:\Users\shawa` is your Windows home folder. It is **not** the bot. If
`cd C:\Users\shawa\Ai-bot` fails, the repo was never cloned on this PC.

## First time (no `Ai-bot` folder yet)

Install Git if `git` is not recognized, then clone:

```powershell
winget install --id Git.Git -e --source winget
```

Close PowerShell, open a new window, then:

```powershell
cd C:\Users\shawa
git clone https://github.com/paraflix246-pixel/Ai-bot.git
cd Ai-bot
.\setup_windows.bat
```

GitHub may ask you to sign in. After setup, put Rithmic credentials in `.env`:

```
BROKER_TYPE=rithmic
ASSET_CLASS=futures
RITHMIC_USER_ID=your_user
RITHMIC_PASSWORD=your_password
RITHMIC_SYSTEM=LucidTrading
```

## Start MNQ live

You must be inside the cloned folder:

```powershell
cd C:\Users\shawa\Ai-bot
.\start_mnq_live.bat
```

Or:

```powershell
cd C:\Users\shawa\Ai-bot
.\venv\Scripts\python.exe -u start_live_rithmic.py --symbol MNQ
```

Paper mode (no live orders):

```powershell
cd C:\Users\shawa\Ai-bot
.\venv\Scripts\python.exe -u start_live_rithmic.py --symbol MNQ --paper
```

You can also double-click `start_mnq_live.bat` in File Explorer **inside** `Ai-bot`.

## If you think you already downloaded it

Search your user folder:

```powershell
Get-ChildItem C:\Users\shawa -Filter start_live_rithmic.py -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
```

`cd` into the folder that contains that file, then run `.\start_mnq_live.bat` or the Python command above.

## Update an existing clone

```powershell
cd C:\Users\shawa\Ai-bot
git pull origin main
```

## Troubleshooting

- **Cannot find path `C:\Users\shawa\Ai-bot`**: run the clone steps above. `git pull` from `C:\Users\shawa` will also fail because that folder is not a git repo.
- **`.\start_mnq_live.bat` not recognized**: you are not in the `Ai-bot` folder. PowerShell only looks in the current directory.
- **`git` is not recognized**: install Git, then open a new PowerShell window.
- **Clone authentication failed**: sign in to GitHub in the browser or use a personal access token.
- **Rithmic connection failed**: fill `RITHMIC_*` in `.env` and confirm your Tradesea/Lucid session is active.
