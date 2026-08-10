---
description: "生成 git 提交信息，使用多行格式 + 中文 + emoji"
argument-hint: "[scope] 可选，如: auth, dashboard, search..."
---

基于暂存区变更，生成符合规范的 git commit message。

## 工作流程

1. **总览** — 先用 `git diff --staged --stat` 看改了哪些文件、各自增删行数
2. **获取变更** — 再取具体 diff，跳过噪音文件：

   ```bash
   git diff --staged -- . \
     ':(exclude)*.wasm' ':(exclude)*.zip' ':(exclude)*.tar.gz' \
     ':(exclude)*.png' ':(exclude)*.jpg' ':(exclude)*.jpeg' ':(exclude)*.gif' \
     ':(exclude)*.webp' ':(exclude)*.ico' ':(exclude)*.pdf' ':(exclude)*.ttf' \
     ':(exclude)*.otf' ':(exclude)*.woff*' ':(exclude)*.so' ':(exclude)*.dylib' \
     ':(exclude)*.jar' ':(exclude)*.aar' ':(exclude)*.keystore' ':(exclude)*.jks' \
     ':(exclude)*.lock' ':(exclude)pubspec.lock' ':(exclude)package-lock.json' \
     ':(exclude)*.g.dart' ':(exclude)*.freezed.dart' \
     ':(exclude)lib/utils/localize/*.dart'
   ```

   - 上面这些**二进制/生成物/锁文件**只从 `--stat` 得知“新增/修改/删除”即可，**不读内容**
   - 单文件 diff 超过 ~500 行时，只看 `--stat` + 文件名推断意图，必要时用 `git diff --staged -- <file> | head -100` 抽样，**不要全量读入**
   - 若整体 diff 过大，按文件逐个 `git diff --staged -- <file>` 分批读

3. **判断类型** — 分析变更核心内容，确定合适的 `type`（参考类型映射表）
4. **推断 scope** — 优先使用用户指定的 scope，否则根据变更文件路径自动推断
5. **拆解要点** — 将变更拆为若干条要点，每条一行 `- <emoji> <描述>`
6. **拆分 commit** — 如果涉及多个不相关改动，建议拆分为多条 commit
7. **输出结果** — 输出最终 commit message 供用户确认

---

## 格式规范

### 完整结构

```
<type>(<scope>): <emoji> <subject>

- <emoji> <变更项 1>
- <emoji> <变更项 2>
...
```

### 各部分规则

| 部分         | 规则                                                                                           |
| ------------ | ---------------------------------------------------------------------------------------------- |
| **subject**  | `type(scope): emoji summary`，summary 使用中文，scope 使用英文                                 |
| **分隔**     | subject 与变更列表之间**空一行**                                                               |
| **变更列表** | 每行以 `- ` 开头，附带 emoji，逐条列出主要变更                                                 |
| **scope**    | 可选。未指定时根据路径推断（如 `app/routes/settings/` → `settings`）。涉及面广难以归纳时可省略 |
| **emoji**    | subject 和每条变更项开头均可附带 emoji 增强可读性                                              |

---

## 参考表

### 类型与 emoji 映射

| Type       | 说明                   | Emoji |
| ---------- | ---------------------- | :---: |
| `feat`     | 新功能                 |  ✨   |
| `fix`      | 修复缺陷               |  🐛   |
| `docs`     | 文档变更               |  📝   |
| `style`    | 代码格式（不影响逻辑） |  💄   |
| `refactor` | 重构优化               |  ♻️   |
| `perf`     | 性能优化               |  ⚡️   |
| `test`     | 测试相关               |  ✅   |
| `chore`    | 构建/工具/依赖         |  🔧   |
| `ci`       | CI/CD 变更             |  👷   |
| `revert`   | 回滚                   |  ⏪   |

### 变更项常用 emoji

| 场景          | Emoji |
| ------------- | :---: |
| 新增文件/模块 |  ✨   |
| 修改/重构     |  ♻️   |
| 删除/移除     |  🔥   |
| 修复缺陷      |  🐛   |
| 文档          |  📝   |
| 性能          |  ⚡️   |
| 数据库迁移    |  🗃️   |
| 配置          |  ⚙️   |
| 依赖          |  📦   |

---

## 示例

```
feat(search): ✨ 支持全文搜索过滤

- ✨ 新增 Meilisearch 搜索后端集成
- 🔍 添加搜索 API 接口 GET /api/v1/search
- 🎨 首页接入搜索框组件
```

```
fix(auth): 🐛 修复 OAuth 回调参数丢失问题

- 🐛 回调 URL 拼接时保留原始 query 参数
- ✅ 添加 state 参数校验逻辑
```

```
docs(api): 📝 补充数据源接口文档

- 📝 新增 datasources API 文档
- 📋 补充请求/响应示例和错误码说明
```

```
chore(deps): 🔧 升级依赖版本

- 📦 Vite 升级到 v7
- 📦 TypeScript 升级到 v5.6
```
