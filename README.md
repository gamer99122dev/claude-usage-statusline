# claude-usage-statusline

在 Claude Code CLI 底部顯示目前模型，以及 5 小時 / 一週剩餘的使用量。

```
Opus 5.5 │ 5h 72% │ Week 88%
```

百分比是「剩餘」量（100 − 已使用）。資料來自 Claude Code 傳給 status line 的 `rate_limits` 欄位，只有 Claude.ai 訂閱（Pro / Max）帳號才有；用 API key 時只會顯示模型名稱。

## 安裝（Windows）

```powershell
git clone https://github.com/gamer99122dev/claude-usage-statusline.git
cd claude-usage-statusline
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

重新啟動 Claude Code 即可。

安裝程式會：

1. 把 `statusline.ps1` 複製到 `~/.claude/`
2. 在 `~/.claude/settings.json` 設定 `statusLine`（其他設定保留，原檔備份為 `settings.json.bak`）

## 更新

腳本每天最多向 GitHub 查一次最新 release（背景執行，不會拖慢狀態列）。有新版時狀態列最後會出現 `│ ↑ v1.1.0`，這時：

```powershell
cd claude-usage-statusline
git pull
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

## 發布新版（維護者）

1. 修改 `statusline.ps1` 第一行的 `$Version`
2. commit、push 後建立同名 release：`gh release create v1.1.0 --generate-notes`

`$Version` 和 release tag 不一致時，使用者會一直看到更新提示（或看不到）。

## 手動安裝

把 `statusline.ps1` 放到 `~/.claude/`，然後在 `~/.claude/settings.json` 加上：

```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell -NoProfile -ExecutionPolicy Bypass -File C:/Users/<you>/.claude/statusline.ps1"
  }
}
```

## 移除

刪掉 `~/.claude/settings.json` 裡的 `statusLine` 區塊（或還原 `settings.json.bak`），再刪除 `~/.claude/statusline.ps1` 和 `~/.claude/statusline-latest.txt`。
