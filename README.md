# claude-usage-statusline

在 Claude Code CLI 底部顯示目前模型，以及 5 小時 / 一週剩餘的使用量。

```
Opus 5.5 │ 5h 72% │ Week 88%
```

百分比是「剩餘」量（100 − 已使用）。資料來自 Claude Code 傳給 status line 的 `rate_limits` 欄位，只有 Claude.ai 訂閱（Pro / Max）帳號才有；用 API key 時只會顯示模型名稱。

## 安裝（Windows）

```powershell
git clone https://github.com/<your-name>/claude-usage-statusline.git
cd claude-usage-statusline
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

重新啟動 Claude Code 即可。

安裝程式會：

1. 把 `statusline.ps1` 複製到 `~/.claude/`
2. 在 `~/.claude/settings.json` 設定 `statusLine`（其他設定保留，原檔備份為 `settings.json.bak`）

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

刪掉 `~/.claude/settings.json` 裡的 `statusLine` 區塊（或還原 `settings.json.bak`），再刪除 `~/.claude/statusline.ps1`。
