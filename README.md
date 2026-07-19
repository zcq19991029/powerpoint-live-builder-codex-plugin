# PowerPoint Live Builder for Codex

一个面向通用备课与课堂教学的 Codex Plugin。它可以规划教学结构、生成可编辑 PowerPoint、制作教学插图、融合图片背景、添加逐元素课堂动画，并在用户明确要求时展示从空白页到成品的现场搭建过程。

## 主要能力

- 教学目标、学情、重难点、例题、练习与课堂小结设计
- 适用于数学、工科、语言、计算机、职业教育和专业培训等课程
- 生成可继续编辑的 `.pptx`，避免整页截图式输出
- 生成并检查教学插图，支持真实像素取色和透明羽化融合
- 添加 PowerPoint 原生“单击淡入”逐元素动画
- 按需进行 PowerPoint 前端空白页到成品展示
- macOS Microsoft PowerPoint AppleScript 自动化
- Windows Microsoft PowerPoint COM/PowerShell 自动化

默认只生成和校验文件。只有用户明确要求“展示制作过程”时，才控制 PowerPoint 前端。

## 调用时的必填需求提醒

Skill 每次启动都会先汇总已知条件，并提供一次“防遗漏”的二次补充提醒：

1. 视觉风格
2. 输出格式与页面比例
3. 中文/英文字体及字号倾向
4. 主色、强调色和学校/机构品牌
5. 动画方式、触发方式和是否自动播放

还会根据任务提示课程主题、学生层次、课时、页数、教学重难点、image2 插图以及是否现场展示。缺失项目会显示暂定默认值，不会静默决定。

提醒不会要求用户重新发起对话，也不会无故停止工作。Skill 会同时继续读取材料、整理教学结构和准备页面提纲；用户可以在当前任务进行中直接输入补充要求或覆盖暂定值，后续生成会自动采用最新约束。只有缺失选择会让成品方向发生重大且不可逆变化时才会暂停确认。

示例填写方式：

```text
课程：机械基础，学生为中职一年级，20分钟；
格式：PPTX、16:9、8页；
风格：职教实训；字体：思源黑体；
配色：深蓝+橙色强调；
动画：单击逐步出现；
插图：需要时必须用image2；
交付：只输出，不现场展示。
```

## 从 GitHub 安装

```bash
codex plugin marketplace add zcq991029/powerpoint-live-builder-codex-plugin
codex plugin add powerpoint-live-builder@ppt-live-tools
```

安装完成后新建一个 Codex 任务，通过更简短的 `$bkppt` 调用。
调用后，Skill 会先针对未确定的风格、比例、字体、配色和动画提供 2–3 个可选方案，标明推荐项及差异；在用户选择期间可继续读取教材和整理大纲，但不会提前进入正式排版与导出。

## 从本地目录安装

```bash
codex plugin marketplace add "/path/to/powerpoint-live-builder-codex-plugin"
codex plugin add powerpoint-live-builder@ppt-live-tools
```

## 使用示例

```text
使用 $bkppt，根据这份教材制作一套面向零基础学生的课堂PPT。
```

```text
使用 $bkppt 生成10页试讲课件，加入逐步讲解动画；只输出文件，不要现场展示。
```

```text
使用 $bkppt 制作课件，并在完成后展示全部页面从空白到成品的搭建过程。
```

## 示例效果

仓库附带一份经过隐私清理的 10 页教学动态 PPT，仅用于展示插图融合、课堂排版和逐元素单击动画，不作为默认主题或模板：

[下载教学动态 PPT 示例](examples/teaching-animation-demo.pptx)

请使用 Microsoft PowerPoint 的“幻灯片放映”模式并逐次单击查看动画。

## 推荐 CLI 与平台差异

### macOS

`cli-anything-wps` 可以创建和编辑 Impress 项目 JSON，但它的 `export render` 使用 Windows WPS COM/pywin32，不能在 macOS 直接导出 `.pptx`。macOS 应使用 Codex 演示文稿工具或 `officecli` 输出最终 PPTX，并建议执行：

```bash
officecli validate output.pptx
officecli view output.pptx issues
```

需要继续编辑或用纯 CLI 创建时，可使用 `officecli create/add/set`。动画时间线和现场展示推荐 Microsoft PowerPoint AppleScript。

安装 officecli：

```bash
curl -fsSL https://d.officecli.ai/install.sh | bash
```

### Windows

安装 WPS Office 与 pywin32 后，可以使用 CLI Anything WPS 通过 WPS COM 直接渲染输出：

```powershell
cli-anything-wps --project project.json export render output.pptx --overwrite
```

Windows 通过 WPS COM 输出时，`officecli` 不是必需项，但仍建议用它进行独立验证。使用 Microsoft PowerPoint 时，也可以调用仓库中的 COM/PowerShell 动画脚本。

CLI Anything WPS 与 WPS COM 依赖可按环境安装：

```powershell
uv tool install cli-anything-wps
py -m pip install pywin32
```

officecli 为可选的独立验证工具：

```powershell
irm https://d.officecli.ai/install.ps1 | iex
```

## 环境说明

- 推荐使用 Microsoft PowerPoint 查看和编辑动画。
- WPS 可以打开输出文件，但 macOS WPS 不支持 CLI Anything WPS 所依赖的 Windows COM 导出路径。
- 推荐安装 `officecli` 用于 PPTX 创建、检查和 OpenXML 验证。
- Windows 可选安装 `cli-anything-wps`、WPS Office 与 pywin32，通过 WPS COM 直接输出。
- 图片边缘融合脚本需要 ImageMagick。
- AI 插图能力取决于当前 Codex 环境是否提供图像生成工具。

## 隐私与安全

- 仓库不包含 API Key、OAuth Token、登录凭据或本机绝对路径。
- 插件不会默认上传教学材料或自动控制桌面应用。
- 前端展示必须由用户明确请求。
