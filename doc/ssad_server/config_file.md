<!-- config_file.md, ssad/doc/ssad_server/
  lang: zh_CN
-->

# ssad_server 配置文件


## `sub_root.json`

位置: `SSAD_CONFIG_ROOT/ssad_server/sub_root.json` <br />
默认路径: `/sdcard/.config/ssad_server/sub_root.json`

```
// 以下 采用 js 语法 描述 文件格式
{
  app: {
    'SSAD_APP_ID': {
      key: '',  // 用来 验证 的 ssad_key
      sub: {
        'SUB_ROOT': {
          path: '',  // sub_root 对应 的 本地路径
          allow: {  // 访问 权限 控制  (以下 为 各项 默认值)
            // 默认 允许 read (下载 普通文件)
            list: true,      // 允许 列出 目录内容 ( GET )
            put: false,     // 允许 上传文件 ( PUT )
            delete: false,   // 允许 删除 文件 ( DELETE )
            replace: false,  // 允许 替换 (更新) 文件 ( PUT )
                             // 仅当 post: true 时 有效
            ro: true,  // 只读 标志 (优先级 高)
                       // 此项 为 true 时, put / delete / replace 都 无效
          }
        }
      }
    }
  }
}
```

示例: (json 语法)
```
{
  "app": {
    "root_app": {
      "key": "?? ?",
      "sub": {
        "sdcard": {
          "path": "/sdcard",
          "allow": {
            "list": true,
            "ro": true
          }
        }
      }
    }
  }
}
```


## `pub_root.json`

位置: `SSAD_CONFIG_ROOT/ssad_server/pub_root.json` <br />
默认路径: `/sdcard/.config/ssad_server/pub_root.json`

```
// 以下 采用 js 语法 描述 文件格式
{
  app: {
    'SSAD_APP_ID': {
      app_meta: ''  // 指向 ssad_app 的 ssad_app.meta.json 文件
    }
  }
}
```

示例: (json 语法)
```
{
  "app": {
    "root_app": {
      "app_meta": "/sdcard/ssad/app/root_app/ssad_app.meta.json"
    }
  }
}
```

服务端 会读取 ssad_app.meta.json 获取 pub_root 信息.


## `root_302`

位置: `SSAD_CONFIG_ROOT/ssad_server/root_302` <br />
默认路径: `/sdcard/.config/ssad_server/root_302`

内容 为 请求 `/` 时 服务端 响应 `HTTP 302` 的 `location`.
如果 此文件 不存在, 则 请求 `/` 时 响应 `HTTP 404`.

示例:
```
/ssad201706/pub/root_app/
```


<!-- end config_file.md -->
