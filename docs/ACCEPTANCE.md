# macOS MVP acceptance baseline

Date: 2026-08-18

## Environment

- macOS 26.6.2 (Apple Silicon / arm64)
- Node.js 24.19.0
- DeepSeek Harness `@deepseek-ai/dsh@0.1.0-rc.7`
- PySide6-Essentials 6.11.2, PyInstaller 6.22.2
- Package candidate: `dsh-dafeiyu@0.1.0-mac.1`

## Functional acceptance

- Node test suite: 24/24 passed (including helper lifecycle/restart and plugin integration).
- Python unit tests: 7/7 passed.
- Real DSH `web` profile loaded the installed plugin from the local `.tgz`.
- A real DSH Host (`dsh --profile web --port 3099`) started the bundled
  Apple Silicon Helper automatically.
- The visual Helper rendered a transparent frameless window and produced a valid
  PNG snapshot (`896×790`, RGBA).
- Stopping the DSH Host exited the Helper and left zero helper processes.

## Package baseline

- npm archive: approximately 67.3 MB compressed, 67.7 MB unpacked.
- Apple Silicon helper executable: approximately 45 MB.
- Final package inventory: 115 files.

## Runtime baseline

- Bundled Apple Silicon Helper headless readiness: immediate (< 1s) in the local test.
- Visual Helper startup includes the Qt/PySide6 one-file boot time; the DSH plugin
  waits for the explicit `ready` handshake with a 60s startup timeout.

These measurements are a local alpha baseline, not a cross-machine performance guarantee.
