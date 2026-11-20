# Git 常用命令与速查指南

> 记录常用的 Git 命令、日常同步工作流以及高频问题排错技巧。

---

## 1. 基础配置与查看

```bash
# 查看全局配置
git config --global --list

# 配置提交作者信息
git config --global user.name "YourName"
git config --global user.email "your_email@example.com"

# 查看当前工作区状态
git status

# 查看提交历史（单行极简显示）
git log --oneline --graph -n 10
```

---

## 2. 日常同步与协作

```bash
# 拉取远端更新并合并
git pull origin main

# 暂存所有改动
git add .

# 提交本地改动
git commit -m "feat: 补充 Qt 笔记"

# 推送到远程仓库
git push origin main
```

---

## 3. 分支操作

```bash
# 查看本地分支
git branch

# 创建并切换到新分支
git checkout -b feature/qt-notes

# 切换回主分支
git checkout main

# 合并分支到当前分支
git merge feature/qt-notes
```

---

## 4. 常见排错与回滚

* **撤销工作区中未暂存的修改**：
  ```bash
  git restore <file>
  ```
* **撤销已暂存的文件（取消 git add）**：
  ```bash
  git restore --staged <file>
  ```
* **修改上一次 commit 的提交信息**：
  ```bash
  git commit --amend -m "新提交信息"
  ```
