# Changelog

## 0.1.0-mac.1

macOS 移植版首个 Alpha。

### Highlights

- 将 Windows 版 DSH 大肥鱼移植到 macOS 14+ Apple Silicon (arm64)
- Helper 使用 PySide6 透明无边框置顶窗口，适配 macOS 窗口行为（所有 Space 可见）
- 「打开文件夹」改用 `open` 在 Finder 中显示
- 布局默认保存到 `~/Library/Application Support/DSH/dsh-dafeiyu/`
- 新增 `scripts/build-helper.sh` 构建 Apple Silicon Helper
- 随包携带预构建 Apple Silicon Helper，普通用户无需安装 Python/PySide6

## 0.1.0-alpha.6

First public Windows Alpha of DSH BigFish / DSH 大肥鱼.

### Highlights

- Native transparent, frameless, always-on-top Windows companion owned by DSH
- Real DSH session states: idle, thinking, working, waiting, success, and error
- Project status card with project directory, current phase, active todo, and real todo progress
- Friendly Simplified Chinese status copy and 49-frame character runtime
- DSH WebUI settings for enable/disable, scale, activity, reduced motion, and subagents
- Helper heartbeat, crash restart, snapshot replay, and automatic exit with the DSH Host
- Bilingual Chinese/English GitHub documentation

### Install the Alpha

```powershell
dsh plugin --profile web add dsh-dafeiyu@alpha
```

If DSH is installed locally rather than globally:

```powershell
pnpm exec dsh plugin --profile web add dsh-dafeiyu@alpha
```

### Current limitations

- macOS 14+ Apple Silicon (arm64) only; Intel Mac support is not included yet
- Settings and desktop status copy are currently Simplified Chinese
- Numeric progress requires a structured todo list from DSH
- Community Electron clients are not part of the supported compatibility scope

Code is MIT-licensed. Bundled character artwork has separate terms documented in
[ASSET_LICENSE.md](ASSET_LICENSE.md). This is an unofficial fan-made project and is not
affiliated with or endorsed by DeepSeek.
