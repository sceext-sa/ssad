<!-- ssad_server_url.md, ssad/doc/ssad_server/
  lang: zh_CN
-->

# ssad_server 的 URL 资源

ssad 作为一个 运行 html5 应用程序 的 框架, 主要为 应用 提供 访问本地文件
的 能力.

同时, 为了 管理 ssad 应用, ssad_server 也具有 管理相关 的 功能.


## ssad_key

ssad_server 使用 ssad_key 提供基本的安全功能.
应用 (浏览器) 访问 ssad_server 的有关资源, 需要通过 ssad_key 验证.

一般一个 ssad_key 对应一个 ssad_app.

+ `ssad_key` 生成方法:

  ```
    ssad_key = sha256(512bit)
  ```

  其中 512bit 随机数据 从 `/dev/urandom` 读取.
  并将 ssad_key 转换成 hex 字符串.

(TODO) ssad_key 表示格式: `ROOT_NAME%KEY` <br />
比如: `root_app%XXX` (*root_key*)


## 文件访问

ssad_server 的 基本功能 即提供 本地文件访问.
将若干 `pub_root` / `sub_root` 映射 为 本地目录.

ssad_server 会 进行 安全检查, 确保 不会访问 对应 本地目录 以外 的 文件.
(比如 指定 本地目录 的 上一级 目录. )

提供 本地文件访问 的 URL 资源 有:

+ `/ssad201706/pub/SSAD_APP_ID/PUB_ROOT/PATH`
+ `/ssad201706/key/SSAD_APP_ID/SUB_ROOT/PATH?ssad_key=XXX`

访问上面的 pub_root 不需要验证, 下面的 sub_root 需要 ssad_key 验证.
如果 ssad_key 验证 不通过, 将 返回 `HTTP 403 Forbidden` 响应.

+ pub_root 由 配置文件 `SSAD_CONFIG_ROOT/ssad_server/pub_root.json`
  ( `/sdcard/.config/ssad_server/pub_root.json` )
  以及 每个 ssad_app 的 `ssad_app.meta.json` 文件 指定.

+ sub_root 由 配置文件 `SSAD_CONFIG_ROOT/ssad_server/sub_root.json`
  ( `/sdcard/.config/ssad_server/sub_root.json` )
  指定.

对 pub_root 的 访问 是 **只读** 的, 允许的 操作 只有:

+ `read`: 访问 (下载) 普通文件
+ `list`: 列出 目录内容 (默认 设置 为 *禁止*)

对 sub_root 的 访问, 根据 `sub_root.json` 配置文件 中 设置的 权限.

+ 对 普通文件, 支持的 操作 (HTTP 方法) 有:

  + `HEAD`: (获取 文件信息)
  + `GET`: 下载文件
  + `POST`: 上传 / 修改 (替换) 文件
  + `DELETE`: 删除文件

+ 对 目录, 支持的 操作 有:

  + `GET`: 列出 目录内容
  + `DELETE`: 删除 目录

+ 对 其它 URL 资源, 仅 支持 `GET` / `POST` (如果 有效) 方法.

如果 使用了 错误的 HTTP 方法, 将 返回 `HTTP 405 Method Not Allowed` 响应.

(TODO) 支持 HTTP `MOVE` 方法 ?


## 列出目录

对一个 目录 进行 `GET` 请求, 将 返回 目录内容 (如果 权限 允许).
格式 为 `json`.

```
// 以下 使用 js 语法 描述 列出目录 格式
{
  path: '',  // 对应的 本地路径
  dir: {
    'NAME': {  // 文件名
      type: '',  // 'dir', 'file', 'unknow'
      size: 0,  // 文件大小 (可选)  (仅对 `type: 'file'` 有效)
    }
  }
}
```

(TODO) 支持 对 非 普通本地 目录 (URL) 进行 `list` ?


## 内置功能

ssad_server 的 内置功能 (java 代码) 由 以下 URL 提供:

+ `/ssad201706/pub/.ssad/PATH`
+ `/ssad201706/key/.ssad/PATH?ssad_key=XXX`

下面 的 key 路径, 由 root_app 使用, 需要通过 root_key 的 验证.
进行 ssad_app / ssad_server 等 的 管理.

### `/ssad201706/pub/.ssad/`
仅 支持 `GET` 请求.

+ **`version`** <br />
  ( `/ssad201706/pub/.ssad/version` )

  获取 ssad (ssad_server) 版本信息 (`json`, 具体格式 TODO)

+ **`key`** <br />
  ( `/ssad201706/pub/.ssad/key` )

  生成 一个 ssad_key (`text/plain`).

### `/ssad201706/key/.ssad/`
支持 `GET` / `POST` (如果有效) 方法.

+ **`config`** <br />
  ( `/ssad201706/key/.ssad/config` )

  + `GET` 方法: 获取 ssad_server 当前相关 配置 ( `?type=XXX` ) (具体 TODO)
  + `POST` 方法: 动态 修改 / 重新载入 ssad_server 配置 (json 格式)


## (TODO) GUI 功能
( `/ssad201706/key/.ssad/gui/` )

+ **`get_local_path`** <br />
  ( `/ssad201706/key/.ssad/gui/get_local_path` )

  (TODO) 用于 弹出 选择 本地 文件/目录 的 GUI 界面. (`POST`)

  (TODO) 单独 的 ssad_key

+ **`show_toast`** <br />
  ( `/ssad201706/key/.ssad/gui/show_toast` )

  TODO  显示 一个 `toast` ? (Android, `POST`)


<!-- end ssad_server_url.md -->
