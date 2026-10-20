# 设计需求排队看板｜部署包

这是静态网页项目，保留原预览的设计风格、需求列表、搜索筛选、状态、登记/编辑、调整顺序和运营只读视图。

## A. 先配置 Supabase（你已经创建了项目和管理员用户）
1. 打开 `config.js`，把 `SUPABASE_ANON_KEY` 的占位文字替换成 Supabase Settings → API Keys 页面上方的 **Publishable key**（以 `sb_publishable_` 开头）。不要使用下方 `sb_secret_`。
2. 在 Supabase → SQL Editor 新建查询，把 `schema.sql` 全部复制进去，点击 Run。它会创建 `design_requests` 表、只读公开策略、只允许管理员邮箱写入的策略，并插入演示数据。
3. 如果你之前已经执行过另一份创建表/权限的 SQL，重复执行前先确认规则没有冲突；若出现报错，把报错截图发给 ChatGPT，不要反复点 Run。

## B. 部署到 Vercel（最简单的无代码方式）
Vercel 通常通过 Git 仓库部署静态项目。
1. 登录 GitHub，创建一个新仓库，名称 `design-queue-board`。
2. 把本文件夹里的 4 个文件上传到仓库根目录：`index.html`、`config.js`、`schema.sql`、`README-中文说明.md`。
3. 回到 Vercel，点击 Add New → Project，导入这个 GitHub 仓库，然后点击 Deploy。
4. 部署完成后，Vercel 会给你一个 `https://...vercel.app` 地址。

## C. 使用方式
- 发给运营的只读链接：在网址后加 `?view=public`，例如 `https://你的域名.vercel.app/?view=public`。运营只能查看，不会显示管理操作。
- 你自己打开普通网址，点击“设计师登录”，使用管理员邮箱和 Supabase Auth 密码登录后，才可登记、编辑和调整队列。
- 上线前请测试：普通只读链接能查看；运营不能写入；管理员登录后可以新增/编辑；另一台设备刷新后能看到同步结果。

## 安全提示
`Publishable key` 可以放在网页端，但必须配合数据库 RLS 策略。绝不要把 `sb_secret_`、`service_role` 或密码写进网页、GitHub 或发给任何人。
