
# git-for-windows-extend

本仓库旨在为 **Git for Windows** 环境提供额外的常用 Linux 工具链扩展，补齐原生 Git Bash 缺失的功能。

所有组建均从 `msys2` 项目提取。

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
./usr/bin/curl.exe
./usr/bin/wcurl
./usr/bin/wget.exe
./usr/bin/nc.exe
./usr/bin/netcat.exe
```

### 终端文本编辑 (Editor)

```text
./usr/bin/micro.exe
```

## 🚀 安装与使用

### 方法 A: 直接解压 (推荐)

将本仓库中的 `usr` 目录内容直接合并到 Git for Windows 的安装根目录（通常是 `C:\Program Files\Git`）。

### 方法 B: 软链接 (适合开发)

如果你不想污染 Git 的原始目录，可以将本仓库的 `bin` 路径添加到 Windows 的 `PATH` 环境变量中。

## 🔗 参考

* [MSYS2 Packages](https://packages.msys2.org/queue)
* [Git for Windows Wiki](https://www.google.com/search?q=https://github.com/git-for-windows/git/wiki)
