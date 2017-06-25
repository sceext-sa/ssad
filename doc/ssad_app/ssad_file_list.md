<!--
  ssad_file_list.md, ssad/doc/ssad_app/
  language: Chinese (zh_cn)
-->
(`zh_CN`)

# ssad_file_list 文档
`ssad_app/ssad_file_list`


## 0. 概述

`ssad_file_list` 是一个基于 `ssad_server` 的 文件 (目录) 浏览 程序,
设计用来 嵌入 ssad_app 使用.


## 1. 嵌入页面 (iframe)

使用 如下 (示例) 代码 将 ssad_file_list 嵌入页面中 使用:

```
<iframe id="ssad_file_list" src="/ssad201706/pub/ssad_file_list/static/dist/ssad_file_list.html?ARGS" ></iframe>
```

其中 `ARGS` 是传递给 ssad_file_list 的 *参数*.


## 2. 参数

完整参数 (示例) 如下:

```
?app_id=ssad_file_list
&ssad_key=49a9f714332b06fda6e6119ece1f898744f8b8bb7b5a34cbd8d722d0fb04176b
&sub_root=sdcard
&root_path=/sdcard
&path=/sdcard/ssad
&show_path=true
```

+ **`app_id`** (必须) <br />
  即 `ssad_app_id`

+ **`ssad_key`** (必须) <br />
  app_id 对应的 `ssad_key`

+ **`sub_root`** (可选) <br />
  指定 `path` 属于 哪个 `sub_root`

+ **`root_path`** <br />
  如果 指定了 `sub_root`, 则 **必须** 同时 指定 此项. 否则无效.

  即 sub_root 对应的 `root_path`

+ **`path`** (可选) <br />
  指定 ssad_file_list 默认 显示的 本地路径 (目录)

  如果 使用 此项, 则 **必须** 指定 `sub_root`, 否则无效.

+ **`show_path`** (可选) <br />
  ssad_file_list 是否 显示 当前路径

  默认值 为 `false`


## 3. 事件 (`event_api`)

ssad_file_list 使用 html5 的 `window.postMessage()` API 向 上一级 页面 发送事件.

使用 如下 (示例) 代码 接收 事件:

```
const iframe = document.getElementById('ssad_file_list');
const w = iframe.contentWindow;

function on_msg(event) {
  if (event.source != w) {
    return;  // event not from the iframe
  }
  const data = event.data;

  console.log('DEBUG: got msg ' + JSON.stringify(data));
}
window.addEventListener('message', on_msg, false);
```

ssad_file_list 发送 的 事件 结构 如下:

```
{
  type: '',    // event type
  payload: {}  // event data
}
```

`type` 指定 事件 类型, 不同 事件 的 `payload` 数据 可能 不同.


**通用数据** <br />
所有 事件 (payload) 都具有 的 数据:

```
{
  app_id: '',
  sub_root: '',   // may be `null`
  root_path: '',  // may be `null`
  path: '',       // may be `null`
}
```

+ **`app_id`** <br />
  参数中 指定 的 app_id

+ **`sub_root`** <br />
  当前 sub_root (可能 为 `null`)

+ **`root_path`** <br />
  当前 sub_root 对应的 root_path
  (如果 sub_root 为 `null`, 则 root_path 也为 `null`)

+ **`path`** <br />
  当前 path (目录 路径)  (可能为 `null`)


**事件类型** <br />
ssad_file_list 可能发送 以下 类型 的 事件:

+ **`error`** <br />
  错误

  `payload` 结构: (示例)

  ```
  {
    app_id: '',
    sub_root: null,
    root_path: null,
    path: null,

    error: 'Forbidden'
  }
  ```

  + **`error`** <br />
    错误信息

+ **`load_dir`** <br />
  (成功) 加载了 新的 目录 (`path` 可能 改变)

  `payload` 结构: (示例)

  ```
  {
    type: 'load_dir',
    payload: {
      app_id: 'ssad_file_list',
      sub_root: 'app',
      root_path: '/sdcard/ssad/app/ssad_file_list',
      path: '/sdcard/ssad/app/ssad_file_list/dist',
    }
  }
  ```

+ **`select_file`** <br />
  用户 选择了 一个 文件 (当前 `path` 下 的 普通文件)

  `payload` 结构: (示例)

  ```
  {
    type: 'select_file',
    payload: {
      app_id: 'ssad_file_list',
      sub_root: 'app',
      root_path: '/sdcard/ssad/app/ssad_file_list',
      path: '/sdcard/ssad/app/ssad_file_list/dist',

      filename: 'main.css'
    }
  }
  ```


<!-- end ssad_file_list.md -->
