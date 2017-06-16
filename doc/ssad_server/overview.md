<!-- overview.md, ssad/doc/ssad_server/
  lang: zh_CN
-->

# `ssad_server` 概述


## 定义

+ **`ssad`** <br />
  SSA **D**aemon (SSA: sceext's Software Stack for Android)

  ssad 是一个在 Android 上运行 html5 应用程序 的 框架.

+ **`ssad_server`** <br />
  ssad 服务端

  ssad_server 是 ssad 的 重要组成部分, 是一个使用 `netty` 框架 的 `http` 服务器.
  ssad_server 为 ssad 应用 提供了 服务端 支持.

+ **`ssad_app`** <br />
  ssad 应用程序

  在 ssad 框架 上 运行的 html5 应用程序.

  + **`root ssad_app`** (`root_app`) <br />
    根 应用程序

    此 应用 用来 管理 其它的 ssad 应用程序.

+ **`ssad_app_id`** <br />
  用来 唯一标识 ssad_app 的 字符串

  ssad_app_id 不允许 重复.

  root_app 的 ssad_app_id 是 `root_app`.

+ **`ssad_config_root`** <br />
  存放 ssad / ssad_server / ssad_app 等 配置文件 的 本地目录

  在 Android 上, 此 路径 为: `/sdcard/.config/`

  相关 配置文件 则 分别位于:

  + **`/sdcard/.config/ssad_server`** <br />
    ssad_server 配置文件

  + **`/sdcard/.config/ssad`** <br />
    ssad 配置文件

  + **`/sdcard/.config/ssad_app/SSAD_APP_ID/`** <br />
    各个 ssad_app 的 配置文件

+ **`ssad_data_root`** <br />
  存放 ssad 的 有关数据

  在 Android 上, 此 路径 为: `/sdcard/ssad/`

+ **`sdcard_root`** <br />
  ssad 可访问的 本地数据 (极限)

  在 Android 上, 此 路径 为: `/sdcard/`

+ **`sub_root`** <br />
  一个 sub_root 映射 为 一个 本地目录

  为 应用 提供 访问 本地文件 的 能力.

+ **`ssad_key`**

  ssad_key 是一个 长随机字符串, 用来提供 ssad 的安全性.

  ssad 应用 访问 服务端 资源, 需要通过 ssad_key 验证.
  一个 ssad_key 可对应 多个 sub_root.

  + **`root ssad_key`** (`root_key`) <br />
    root_app 使用 的 ssad_key

    此 key 对整个 ssad_server 具有管理权限.


TODO: ssad_server 日志文件 ?


## ssad_server 本地 文件结构

+ **配置文件** <br />
  ( `/sdcard/.config/` )

  ```
  + SSAD_CONFIG_ROOT/
    + ssad_server/
      - sub_root.json
      - pub_root.json
      - root_302
    + ssad/
    + ssad_app/
      + SSAD_APP_ID/
  ```

+ **数据文件** <br />
  ( `/sdcard/ssad/` )

  ```
  + SSAD_DATA_ROOT/
    + app/
      + SSAD_APP_ID/
        - ssad_app.meta.json
    + data/
      + SSAD_APP_ID/
    + log/
      + SSAD_APP_ID/
    + tmp/
      + SSAD_APP_ID/
    + cache/
      + SSAD_APP_ID/
  ```


## ssad_server URL 资源

ssad_server 在 `127.0.0.1` 的 指定端口 listen.

+ **`/`** <br />
  默认 重定向 (302) 到 `/ssad201706/pub/root_app/`

+ **`/ssad201706/`** <br />
  ssad_server 所有功能, 位于 此 路径 之下

+ **`/ssad201706/pub/`** <br />
  无需 ssad_key 验证, 即可 访问 的 资源.

+ **`/ssad201706/pub/.ssad/`** <br />
  ssad_server 内置 的 功能 (java 代码)

+ **`/ssad201706/pub/SSAD_APP_ID/PUB_ROOT/PATH`** <br />
  ssad_app 可 公开访问 的 (静态) 本地文件 资源

  如 `/ssad201706/pub/root_app/static/`

+ **`/ssad201706/key/`** <br />
  需要 通过 ssad_key 验证, 才 可以 访问 的 资源.

  格式 为: `/ssad201706/key/XXX?ssad_key=YYY`

+ **`/ssad201706/key/.ssad/`** <br />
  ssad_server 内置 的 功能 (java 代码)

+ **`/ssad201706/key/SSAD_APP_ID/SUB_ROOT/PATH`** <br />
  ssad_app 可访问 的 sub_root 资源

  通过 同一个 ssad_key 验证.


## ssad_server 配置

默认配置: (on Android)

```
SSAD_CONFIG_ROOT = /sdcard/.config/
SSAD_DATA_ROOT = /sdcard/ssad/
SDCARD_ROOT = /sdcard/

ROOT_APP = root_app  # ssad_app_id of root_app
```

TODO: root_key 随机 生成 ?


调试 配置:

```
SSAD_CONFIG_ROOT = tmp/sdcard/.config/
SSAD_DATA_ROOT = tmp/sdcard/ssad/
SDCARD_ROOT = tmp/sdcard/
```


<!-- end overview.md -->
