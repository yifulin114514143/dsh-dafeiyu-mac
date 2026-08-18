<div align="center">

# DSH BigFish 🐋

**A desktop companion that lives on macOS and reacts to real DeepSeek Harness activity.**

Enabled by DSH, owned by the DSH lifecycle, rendered on the desktop.

[中文](README.md) · [GitHub](https://github.com/yifulin114514143/dsh-dafeiyu-mac) · [Latest release](https://github.com/yifulin114514143/dsh-dafeiyu-mac/releases/tag/v0.1.0-mac.1) · [Update and rollback](docs/UPDATING.md) · [Acceptance notes](docs/ACCEPTANCE.md)

</div>

![DSH BigFish showing live project status](docs/images/dsh-bigfish-running.png)

DSH BigFish is not a standalone desktop-pet application. DSH enables the plugin, starts and
stops its native Helper, and provides the Agent events that drive it. The transparent,
frameless companion stays above other macOS apps, so you can see whether DSH is thinking,
editing, testing, waiting, or finished while working in VS Code, a browser, or Finder.

> Current version: `0.1.0-mac.1` (macOS port) · macOS 14+ Apple Silicon (arm64)

> This repository is a **macOS port** of
> [nolodjska/dsh-dafeiyu](https://github.com/nolodjska/dsh-dafeiyu) (the Windows version).
> The core animation, state machine, and DSH event protocol stay compatible; the desktop
> layer uses macOS-native window behavior and ships an Apple Silicon Helper.
> It is **not published to npm** — install from this repository.

## What is it for?

- **See DSH status away from the WebUI:** BigFish stays on top of the macOS desktop.
- **React to real Agent events:** it does not inspect the screen or mistake activity in other apps for DSH work.
- **Show useful, compact context:** the card can display the project, current phase, active step, and real todo progress.
- **Feel alive without becoming noisy:** thinking, searching, editing, commands, testing, waiting, success, and errors have distinct motion and friendly copy.
- **Avoid a second app experience:** users do not launch the Helper, install Python, or configure another port.

If DSH has not emitted a structured todo list, BigFish shows reliable phases such as
“Analysis,” “Implementation,” or “Verification” instead of inventing a percentage.

## Status previews

| Thinking | Working |
| --- | --- |
| ![BigFish thinking](docs/images/status-thinking.png) | ![BigFish working](docs/images/status-working.png) |

| Waiting for you | Complete |
| --- | --- |
| ![BigFish waiting for user confirmation](docs/images/status-waiting.png) | ![BigFish task complete](docs/images/status-success.png) |

| Needs attention |
| --- |
| ![BigFish error status](docs/images/status-error.png) |

The high-level state flow is:

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Thinking: DSH starts a turn
    Thinking --> Working: search, read, edit, command, or test
    Working --> Thinking: organize tool results
    Thinking --> Waiting: user confirmation required
    Working --> Waiting: user confirmation required
    Thinking --> Success: turn completed
    Working --> Success: turn completed
    Thinking --> Error: turn ended abnormally
    Working --> Error: tool or turn failed
    Waiting --> Thinking: user continues
    Error --> Thinking: user retries
    Success --> Idle
```

When several DSH sessions run at once, the default attention priority is:

`Waiting > Error > Working > Thinking > Idle`

Working-state details:

- **No flicker between consecutive tools:** once a turn uses a tool, the pet keeps the
  working (seated) pose until the turn ends instead of standing up, thinking, and sitting
  down again between every tool.
- **Balancing work and lookups:** quick searches interleaved with edits (< 1.2s) keep the
  seated pose; only sustained searches (≥ 1.2s) make the pet pick up the book, and only
  long ones (≥ 2.4s) end with the starry/happy celebration.
- **Status-card caption:** while asking a question the caption shows the actual question,
  wrapping onto extra lines and growing the card when it does not fit.

## Requirements

- macOS 14+ (Apple Silicon / arm64)
- A working DeepSeek Harness WebUI installation
- A DSH CLI that supports `plugin --profile web`
- The source archive of this repository (`yifulin114514143/dsh-dafeiyu-mac`), or a `.tgz` from
  GitHub Releases

Regular users do **not** need Python or PySide6 and should not launch
`dsh-dafeiyu-helper` manually. The Apple Silicon Helper is bundled in the release archive.

The current Alpha build uses Simplified Chinese for the settings UI and desktop status copy.

## Install

### 1. Fully exit DSH

Stop the DSH Host, not only the browser tab. An old Helper should not remain active during
installation or upgrade.

### 2. Install from source

This repository is a **macOS port** of
[nolodjska/dsh-dafeiyu](https://github.com/nolodjska/dsh-dafeiyu) and is **not published to npm**.
Clone the repository (or
download a ready-made `dsh-dafeiyu-<version>.tgz` from
[GitHub Releases](https://github.com/yifulin114514143/dsh-dafeiyu-mac/releases/tag/v0.1.0-mac.1)), then in the
repository directory run:

```bash
cd /path/to/dsh-dafeiyu-mac
npm pack
```

This produces `dsh-dafeiyu-0.1.0-mac.1.tgz` (the prebuilt Apple Silicon Helper is bundled;
**do not extract it**). Install it from the DSH directory:

```bash
cd /path/to/DSH
pnpm exec dsh plugin --profile web add "/path/to/dsh-dafeiyu-mac/dsh-dafeiyu-0.1.0-mac.1.tgz"
```

If `dsh` is already available globally, replace `pnpm exec dsh` with `dsh`.

### 3. GitHub Release fallback

Open [GitHub Releases](https://github.com/yifulin114514143/dsh-dafeiyu-mac/releases/tag/v0.1.0-mac.1) and download:

```text
dsh-dafeiyu-<version>.tgz
```

Do not extract it. Install the downloaded archive from the DSH directory:

```bash
pnpm exec dsh plugin --profile web add "~/Downloads/dsh-dafeiyu-<version>.tgz"
```

### 4. Start DSH

Launch the DSH WebUI normally. The plugin is enabled by default, and DSH starts BigFish
automatically. Do not start the Helper yourself.

### 5. Open the settings

In the DSH WebUI, go to (recommended):

```text
Settings → Desktop Pet
```

The **Desktop Pet** page offers the portrait, the enable toggle, and the action-loop photo
wall. All settings are also available under:

```text
Settings → Plugins → Plugin configuration → BigFish Desktop Companion
```

![DSH BigFish plugin settings](docs/images/dsh-bigfish-settings.png)

## How to use it

There is no separate workflow after installation:

1. Start DSH.
2. Begin a project task in DSH.
3. BigFish reacts to real DSH events and updates its animation and status card.
4. Switch to another app; BigFish remains above the desktop.
5. BigFish exits automatically when the DSH Host actually stops.

The status card can show:

- the project directory, such as `dsh-dafeiyu`
- the current phase, such as Analysis, Implementation, or Verification
- the active todo, such as “Improve project documentation”
- real progress, such as “3/5 steps complete”
- waiting, success, or error messages

BigFish does not watch VS Code, browsers, or other apps and does not take screenshots. Only
DSH Agent events can change its work state.

## Settings

| Setting | Purpose |
| --- | --- |
| Enable BigFish | Show or stop the desktop companion immediately |
| Character size | Scale the character from 70% to 140% |
| Activity level | Control the frequency of idle blinks and micro-animations |
| Reduced motion | Reduce walking, looping frames, and procedural movement |
| Include subagents | Allow subagent sessions to participate in status priority; off by default |

DSH persists these settings, so a normal plugin update does not require reconfiguration.

## Desktop interactions

- **Drag:** move BigFish; its position is saved automatically.
- **Click or double-click:** trigger brief head-pat, poke, or tail reactions, then return to the latest DSH state.
- **Question/answer:** when DSH asks you something (`ask_user_question`), the `question`
  face shows and stays, and the status-card caption displays the actual question (wrapping
  and growing the card when it does not fit on one line). After you answer, the `answer`
  face shows briefly (~2.4s) before returning.
- **Right-click:** change size, reduce motion, hide for now, or close for this run.
- **Hide for now:** hides the window without disabling the plugin.
- **Close for this run:** closes the current Helper and suppresses restart until the next DSH launch.

## Update

An installed plugin does **not** change when new commits appear on GitHub. To update, fully
exit DSH, pull the latest code in the repository and repack it:

```bash
cd /path/to/dsh-dafeiyu-mac
git pull
npm pack
cd /path/to/DSH
pnpm exec dsh plugin --profile web add "/path/to/dsh-dafeiyu-mac/dsh-dafeiyu-<version>.tgz"
```

Users who installed from GitHub Releases can download the new `.tgz` and install it over the
old version. Either path replaces the plugin and bundled Apple Silicon Helper while retaining
settings saved by DSH. See [Update and rollback](docs/UPDATING.md) for details.

## Roll back

Fully exit DSH and install a previously saved release archive with the same `add` command:

```bash
cd /path/to/DSH
pnpm exec dsh plugin --profile web add "~/Downloads/dsh-dafeiyu-<old-version>.tgz"
```

## Uninstall

Fully exit DSH, then run:

```bash
cd /path/to/DSH
pnpm exec dsh plugin --profile web remove dsh-dafeiyu
```

Restart DSH afterward. The plugin and Helper are removed from the `web` profile. DSH may keep
an inactive copy of historical settings; it does not start a process or open a port.

## Troubleshooting

<details>
<summary><strong>BigFish does not appear after installation</strong></summary>

1. Confirm that you installed into `--profile web`.
2. Fully stop and restart the DSH Host.
3. Open “Settings → Desktop Pet” and confirm that the “Enable desktop pet” toggle is on.
4. Use the macOS arm64 release archive. A source-only clone may not contain the prebuilt Helper.

</details>

<details>
<summary><strong>macOS says the Helper cannot be verified or nothing happens</strong></summary>

If a release downloaded from GitHub is blocked by Gatekeeper on first run, clear the
quarantine attribute on the Helper and retry:

```bash
xattr -dr com.apple.quarantine "$HOME/.dsh/profiles/web/node_modules/dsh-dafeiyu/runtime/bin/darwin-arm64/dsh-dafeiyu-helper"
```

Then fully restart DSH.

</details>

<details>
<summary><strong>Why does BigFish remain after I close the DSH browser tab?</strong></summary>

BigFish follows the DSH Host lifecycle, not the browser tab. It remains visible while the DSH
backend is still alive and exits when the Host actually stops.

</details>

<details>
<summary><strong>Why is there no numeric progress?</strong></summary>

The plugin can calculate “3/5 steps complete” only when DSH emits a structured todo list.
Without real progress data, the card shows the current phase instead of inventing a percentage.

</details>

<details>
<summary><strong>Why does BigFish not restart after “Close for this run”?</strong></summary>

That command intentionally suppresses automatic restart for the current DSH run. Fully restart
DSH to bring it back. To disable it permanently, turn off “Enable BigFish” in DSH settings.

</details>

## Privacy and boundaries

- Does not read or store model API keys
- Does not take screenshots or inspect other windows
- Does not send telemetry
- Does not monitor keyboard input or other app activity
- Does not open a new network port; the settings card reuses DSH's local Web service
- Follows the most recently active top-level DSH session by default

## Development and tests

```bash
pnpm install
npm test
python3 -m unittest discover -s runtime/tests -t .
```

Developers can run the source Helper directly, but regular users should not:

```bash
python3 -m pip install -r requirements.txt
python3 runtime/helper.py
```

Build the Apple Silicon Helper:

```bash
python3 -m pip install -r requirements.txt pyinstaller
npm run build:helper:mac
```

## More documentation

- [Product scope and trade-offs](docs/PRODUCT_SCOPE.md)
- [Execution plan](docs/EXECUTION_PLAN.md)
- [Compatibility spike](docs/PHASE0.md)
- [macOS acceptance and performance](docs/ACCEPTANCE.md)
- [Update, rollback, and uninstall](docs/UPDATING.md)
- [Character asset license](ASSET_LICENSE.md)

Upstream project: [nolodjska/dsh-dafeiyu](https://github.com/nolodjska/dsh-dafeiyu) is the
Windows version. This repository is its macOS port — a DSH-only companion plugin.

## License

Code is released under the [MIT License](LICENSE). Character artwork is not covered by the MIT
code license; see [ASSET_LICENSE.md](ASSET_LICENSE.md) for provenance and usage boundaries.
