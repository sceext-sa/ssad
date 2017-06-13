<!-- ssad_app.md, ssad/doc/ssad_server/
  lang: zh_CN
-->

# ssad_app


## 默认 sub_root

当 安装 (?) 一个 ssad_app 时, root_app 会 自动指定 如下 sub_root:
(并且 映射 到 相应 本地目录. )

+ `/ssad201706/key/SSAD_APP_ID/app/` <br />
  -> `/sdcard/ssad/app/SSAD_APP_ID/`

  (包含 `ssad_app.meta.json` )

+ `/ssad201706/key/SSAD_APP_ID/etc/` <br />
  -> `/sdcard/.config/ssad_app/SSAD_APP_ID/`

  应用 配置文件

+ `/ssad201706/key/SSAD_APP_ID/data/` <br />
  -> `/sdcard/ssad/data/SSAD_APP_ID/`

  数据文件

+ `/ssad201706/key/SSAD_APP_ID/log/` <br />
  -> `/sdcard/ssad/data/SSAD_APP_ID/`

  日志文件

+ `/ssad201706/key/SSAD_APP_ID/tmp/` <br />
  -> `/sdcard/ssad/tmp/SSAD_APP_ID/`

  临时文件

+ `/ssad201706/key/SSAD_APP_ID/cache/` <br />
  -> `/sdcard/ssad/cache/SSAD_APP_ID/`

  缓存文件

应用 对 以上 目录, 具有 完全 操作 权限:

```
{
  "allow": {
    "list": true,
    "post": true,
    "delete": true,
    "replace": true,
    "ro": false
  }
}
```


## 用户 定义 sub_root

用户 可 通过 root_app 的 管理功能, 为 每个 应用 添加 一些 sub_root.

这些 sub_root 默认 为 **只读** 权限:

```
{
  "allow": {
    "list": true,
    "post": false,
    "delete": false,
    "replace": false,
    "ro": true
  }
}
```

用户 可 根据需要, 为 应用 设置 更多 权限.

(TODO) 应用 `GET /ssad201706/key/SSAD_APP_ID/` 可以 `list` 出来,
本应用 具有 哪些 sub_root.


# `ssad_app.meta.json` 文件

```
// 下面 使用 js 语法 描述 文件 格式
{
  ssad_app_spec: '0.1.0',  // ssad_app 规范 版本号

  id: '',       // ssad_app_id
  name: '',     // 用户友好 的 显示名称
  version: '',  // 应用 版本号

  main: '',  // 当 访问 `/ssad201706/pub/SSAD_APP_ID/` 时
             // 重定向 的 相对路径 (比如 `static/main.html`
             // 将会 重定向 至 `/ssad201706/pub/SSAD_APP_ID/static/main.html` )
  pub_root: {  // 定义 本应用 的 pub_root
    'PUB_ROOT': {  // pub_root 的 名称
      sub_root: '',  // 对应 的 本应用 的 sub_root
      path: '',  // 相对于 sub_root 的 路径
                 // pub_root 不能 超出 sub_root 的 范围
      allow: {  // 访问 权限, 以下 为 默认值
        list: false,  // 允许 列出 目录内容
      }
    }
  },

  // 以下 为 可选 项目
  license: '',
  author: '',
  home: '',  // 项目 主页

  // 自定义 数据 (项目), 请以 `_` (下划线) 起始
}
```

以下 是 一个 `ssad_app.meta.json` 文件 的 示例:

```
{
  "ssad_app_spec": "0.1.0",

  "id": "root_app",
  "name": "ssad APP 管理器 (root_app)",
  "version": "0.1",

  "main": "static/main.html",
  "pub_root": {
    "static": {
      "sub_root": "app",
      "path": "/",
      "allow": {
        "list": false
      }
    }
  },

  "license": "GNU GPL v3+",
  "author": "sceext",
  "home": "https://github.com/sceext-sa/ssad",

  "_test": "OK"
}
```


<!-- end ssad_app.md -->
