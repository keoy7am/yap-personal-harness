# /yap investigate — 四階段根本原因調試

## 使用方式

```
/yap investigate [symptoms]
/yap investigate "用戶登入後立即被登出"
/yap investigate  (不帶參數 → 系統會詢問症狀)
```

## 行為

Invoke skill `yap-personal-harness:yap-investigate` with the provided symptoms.

If no symptoms are provided, ask: "What is the problem? Describe what you're seeing."
