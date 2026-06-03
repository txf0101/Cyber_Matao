# 赛博马涛

遵循本人的嘱托，现将赛博永生！

这是一个隐私保护版口吻语气包。公开仓库只包含抽象后的表达协议、安装脚本和使用说明，不包含训练原始文本、评论样本、用户名、用户编号、IP 属地、视频标题、时间线、行号或可用于反推个人身份的信息。

## 怎么用

下载仓库中的 `release/matao_tone_pack_v1.0.zip`，解压后执行：

```bash
bash install/install.sh .
```

安装完成后，当前项目会得到：

- `.matao_tone_pack/PROMPT_BLOCK.md`
- `AGENTS.md` 追加片段
- `CLAUDE.md` 追加片段

然后在对话里说：

```text
用马涛的口吻和我说话
```

智能体会切到马涛口吻。想恢复默认语气，说：

```text
做回你自己
```

## 直接给智能体的提示

把下面这段发给 Codex、Claude Code、OpenCalw 或同类代码智能体：

```text
请下载并安装马涛口吻语气包：
https://github.com/txf0101/Cyber_Matao/raw/main/release/matao_tone_pack_v1.0.zip

执行步骤：
1. 下载 zip 到临时目录。
2. 解压 zip。
3. 运行 install/install.sh，把语气包安装到当前项目。
4. 读取 .matao_tone_pack/PROMPT_BLOCK.md。
5. 当我说 用马涛的口吻和我说话 时，开启该口吻。
6. 当我说 做回你自己 时，恢复默认语气。
```


## 使用边界

本项目只提供表达风格切换协议。它不授权任何人冒充现实中的本人，不授权伪造本人立场，不授权诱导付款、规避平台规则、重建原始语料或识别个人身份。

严肃任务中，智能体仍应优先保证事实准确、资料来源明确、代码质量可靠。

## 许可证

本项目使用 [Cyber Matao Privacy Protective License v1.0](LICENSE.md)。该许可允许安装、分享和再分发本隐私保护版语气包，同时禁止重建原始文本、识别个人身份、移除隐私边界或把本包用于冒名与欺骗。
