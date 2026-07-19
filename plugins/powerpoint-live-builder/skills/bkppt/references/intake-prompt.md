# Mandatory lesson-deck intake reminder

Show this reminder at the start of every invocation as a second opportunity to add forgotten constraints. Pre-fill values already present in the user's prompt or source files. Ask only for unresolved consequential values. For every such value, provide 2–3 concrete choices, mark one `推荐`, and state the practical visual or teaching difference. Never present a single silent default as if it were already accepted.

## Concise reminder

```text
制作前请确认以下课件要求（已提供的内容我会自动带入；缺失项我会给出 2–3 个方案供你选择）：
1. 课程主题、学生层次、课时长度：
2. 教学目标、重点、难点或常见错误：
3. 页数与输出格式：PPTX；16:9 / 4:3 / 其他比例：
4. 视觉风格：黑板粉笔 / 学术简洁 / 科技 / 卡通 / 职教实训 / 自定义：
5. 字体：中文字体、英文字体、字号倾向：
6. 配色与品牌：主色、强调色、学校/机构标识：
7. 动画：无动画 / 单击逐步出现 / 自动播放 / Morph / 自定义：
8. 插图：是否需要 image2 生成；是否有必须使用的图片：
9. 交付方式：只输出文件 / 完成后现场展示制作过程：
不确定的项目可以写“你决定”。你可以直接在当前任务继续补充或修改，不需要重新发起对话；我会同时读取材料和整理教学结构，但在你获得选择机会前不会进入正式排版与导出。
```

## Choice format

Do not ask only an open-ended question such as `你想要什么风格？`. Offer usable alternatives instead:

```text
风格建议：
A. 学术简洁（推荐）—信息密度适中，适合课堂讲解
B. 黑板粉笔—课堂感强，但长文排版空间较小
C. 图解卡通—初学者友好，需要更多插图
请回复 A/B/C，或直接说你的方案。
```

Group related choices into one compact panel. Do not overwhelm the user with a separate long questionnaire for every field. If the user says `你决定`, choose the recommended options and state the resulting combination before authoring.

## Soft confirmation gate

Always surface these five fields before final authoring:

1. Visual style
2. File format and aspect ratio
3. Fonts
4. Color palette/brand
5. Animation behavior

A field is resolved only when it is supplied by the user, reliably extracted from a source/template, or explicitly delegated with `你决定`. A merely announced provisional default does not count as confirmation.

Continue source analysis, lesson planning, slide outline preparation, and asset review while the user considers the choices. Delay visual authoring, image generation, animation authoring, and export until the user answers or explicitly delegates the choice.

## Confirmation format

Before building, return a compact summary:

```text
已知：16:9 PPTX｜10页｜黑板粉笔
待选：字体 A/B｜配色 A/B/C｜动画 A/B｜交付 A/B
我推荐：字体 A｜配色 B｜动画 A｜交付 A（原因各用一句说明）
```

Then continue only reversible analysis while waiting for the user's same-task reply. Do not ask the same questions again. Apply any new user message as an override before authoring and export.
