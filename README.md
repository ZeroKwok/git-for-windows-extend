
# git-for-windows-extend

本项目致力于为 **Git for Windows (Git Bash)** 提供常用 **Unix/Linux 工具链扩展**，旨在补齐原生环境缺失的功能，构建更完整的 Windows 类 Unix 工作流。

所有组件均提取自 [MSYS2](https://www.msys2.org/) 项目。

**当前适配版本：** `Git-2.53.0.2-64-bit`

---

## 项目背景 (Why this project?)

### 1. 追求跨平台的一致性

个人非常喜欢在 Windows 上通过 **Git Bash 终端** 使用 **Unix 工具链**，这种跨平台的工作流一致性极大地提升了工作、开发效率。然而，原生 Git Bash 自带的工具集较为精简，难以满足作为重度终端用户的需求（比如缺失 `rsync`, `wget`, `nc`, `curl`, `micro` 等）。

### 2. 原生 Git for Windows 的不可替代性

虽然 MSYS2 官方仓库也提供 Git 安装包，但其在以下方面的体验仍逊色于官方 **Git for Windows**：

* **系统兼容：** 更好的 Windows 符号链接（Symlinks/Junctions）支持。
* **凭据管理：** 与 Windows 凭据管理器（Git Credential Manager）的深度集成。
* **交互细节：** 针对 Windows 控制台和路径转换的优化。

### 3. 规避复杂的配置陷阱

目前网络上流传的“为 Git Bash 安装 pacman 包管理器”的方案往往存在问题。

我也尝试过 Git for Windows 与 MSYS2 或者  Git for Windows 与 Cygwin 共存，但均存在各种兼容性问题。

**本仓库采取了更轻量、更稳定的方案：** 直接提取 MSYS2 的工具二进制及其依赖库，以“插件化”的方式扩展 Git Bash。

## 📥 组件清单

### 远程访问 (OpenSSH Server)

提供了在 Windows Git Bash 环境下启动 SSH 服务的能力。

```text
`-- usr
    |-- bin
    |   `-- sshd.exe
    `-- lib
        `-- ssh
            |-- sshd-auth.exe
            `-- sshd-session.exe
```

使用方法：

```sh
# 首次运行需要生成主机密钥 (位于：/etc/ssh/)
ssh-keygen -A

# 启动服务（需要绝对路径， 如果远程用户需要管理员权限，则需要管理员权限启动服务）
/usr/bin/sshd.exe -D
```

### 文件同步 (rsync)

用于快速、增量地在本地或远程服务器间同步文件。

```text
`-- usr
    |-- bin
    |   |-- msys-xxhash-0.dll
    |   |-- rsync-ssl
    |   `-- rsync.exe
    `-- lib
        `-- rsync
            `-- rrsync
```

### 网络与传输工具 (Networking)

```text
./usr/bin/wget.exe
./usr/bin/nc.exe
./usr/bin/netcat.exe
./usr/bin/msys-md-0.dll
```

### 系统/进程监视

用于监视系统及其进程的实用程序来自 procps-ng

```text
/usr/bin/free.exe
/usr/bin/msys-proc2-1.dll
/usr/bin/pgrep.exe
/usr/bin/pidof.exe
/usr/bin/pkill.exe
/usr/bin/pmap.exe
/usr/bin/procps.exe
/usr/bin/top.exe
/usr/bin/uptime.exe
/usr/bin/vmstat.exe
/usr/bin/w.exe
/usr/bin/watch.exe
```

### 终端文本编辑 (Editor)

```text
./usr/bin/micro.exe
```

## 🚀 安装与使用

将本仓库中的 `usr` 目录内容直接合并到 Git for Windows 的安装根目录（通常是 `C:\Program Files\Git`）。

## 🔗 参考

* [MSYS2 Packages](https://packages.msys2.org/queue)
* [Git for Windows Wiki](https://www.google.com/search?q=https://github.com/git-for-windows/git/wiki)
