# /yap — yap-personal-harness 統一入口

## 使用方式

```
/yap              → 顯示 Harness 狀態摘要
/yap status       → 顯示完整配置 + provider 狀態
/yap workflow     → 啟動 4-phase 工作流（research → plan → implement → review）
/yap config       → 顯示 ~/.claude/yap-personal-harness.json 內容
/yap config set <key> <value>  → 修改配置值
```

## 行為定義

### `/yap` 或 `/yap status`

1. Read `~/.claude/yap-personal-harness.json`
2. 輸出：
   ```
   yap-personal-harness v<version>
   Memory:   <provider>  [available: claude-mem | serena | local | none]
   Planning: <provider>  [available: yap-plan | gstack]
   Review:   <workflow.review_command>
   Config:   ~/.claude/yap-personal-harness.json
   ```
3. 驗證各 provider 的 MCP 工具是否可用，旁邊標示 ✅ 或 ⚠️

### `/yap workflow`

Invoke skill `yap-personal-harness:harness-workflow-chain`

### `/yap config`

Read `~/.claude/yap-personal-harness.json` 並以格式化方式輸出。

### `/yap config set <key> <value>`

使用點記法設定配置值。例：
- `/yap config set memory.provider serena` → 切換記憶 provider
- `/yap config set planning.provider yap-plan` → 切換規劃 provider
- `/yap config set workflow.confirm_between_phases false` → 關閉 phase 間確認

步驟：
1. Read `~/.claude/yap-personal-harness.json`
2. 解析 key（支援點記法如 `memory.provider`）
3. 更新對應值
4. Write 回文件
5. 確認：`✅ Set <key> = <value>`
