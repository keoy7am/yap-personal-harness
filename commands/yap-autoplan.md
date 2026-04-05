# /yap autoplan — 序列多視角計劃審查

## 使用方式

```
/yap autoplan
/yap autoplan [plan-file-path]
```

## 行為

Invoke skill `yap-personal-harness:yap-autoplan`.

If a plan file path is provided, pass it to the skill. Otherwise the skill will find the most recent plan in `~/.claude/plans/`.

Review sequence: CEO → Eng → DX → Design (if UI detected)
