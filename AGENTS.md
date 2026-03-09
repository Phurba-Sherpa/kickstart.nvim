# AGENTS.md
Guidance for coding agents working in this Neovim config repository.

## Repo Snapshot
- Language: Lua
- Entry point: `init.lua`
- Plugin manager: `lazy.nvim`
- Core modules: `lua/core/*`
- Plugin specs/config: `lua/plugins/*`
- Lockfile: `lazy-lock.json`

## Cursor/Copilot Rule Files
Checked and currently absent:
- `.cursor/rules/`
- `.cursorrules`
- `.github/copilot-instructions.md`
If any appear later, treat them as higher-priority instructions than this file.

## Build, Lint, Format, Test Commands
Run from repo root: `/Users/phurba/.config/nvim`.

### Build-equivalent / startup validation
```bash
nvim --headless +qa
```

### Sync plugins from lockfile
```bash
nvim --headless "+Lazy! restore" +qa
```
Use this after fresh clone or when `lazy-lock.json` changes.

### Health diagnostics
```bash
nvim --headless "+checkhealth" +qa
```

### Formatting
Configured formatter:
- Lua via `stylua` (also runs in-editor through `conform.nvim`)
CLI:
```bash
stylua init.lua lua/
```

### Linting
Configured via `nvim-lint`:
- Markdown: `markdownlint`
- JSON: `jsonlint`
- JavaScript/TypeScript: `eslint`
Useful CLI examples (if installed):
```bash
npx markdownlint-cli "**/*.md"
npx jsonlint "**/*.json"
npx eslint .
```
Lua diagnostics are primarily handled by `lua_ls` (LSP).

### Tests
Current state: no dedicated test suite in this repository.
- No `tests/` directory
- No `*_spec.lua` files
Baseline validation:
```bash
nvim --headless +qa
```

### Running a single test (important)
There is no active single-test command today because no tests exist yet.
If Plenary/Busted tests are added, use:
```bash
nvim --headless -u ./init.lua -c "PlenaryBustedFile tests/path/to/file_spec.lua" -c "qa"
```
If your test harness supports per-test filters, pass its matcher flags to run one case.

## Code Style Guidelines
Follow existing style in edited files; avoid broad reformatting.

### File/module organization
- Keep editor behavior in `lua/core/*`.
- Keep plugin specs in `lua/plugins/*`.
- Each plugin file should `return` a plugin spec table (or list of spec tables).
- Add new plugin modules under `lua/plugins/` and require them from `init.lua`.

### Imports / requires
- Use `require("module.path")`.
- Prefer local `require(...)` inside `config` functions when used only there.
- Keep top-level requires minimal.
- Avoid circular dependencies between modules.

### Formatting and layout
- Preserve indentation style per file (many files use tabs; some use spaces).
- Keep lines readable; target around 100 columns (`colorcolumn=100`).
- Use trailing commas in multiline tables.
- Prefer one key/value per line in larger tables.

### Types and API usage
- Use EmmyLua annotations when helpful (`---@type`, `---@module`).
- Keep table shapes explicit and easy to read.
- Match Neovim API argument types exactly (`string`, `table`, `function`).

### Naming conventions
- Filenames: lowercase and descriptive.
- Locals: `snake_case`.
- Augroup names: descriptive strings (e.g. `"kickstart-lsp-attach"`).
- Keymap descriptions: concise prefixes like `"LSP: ..."`, `"Debug: ..."`.

### Error handling and resilience
- Fail fast for critical bootstrap failures.
- Guard OS/tool-dependent logic with checks like:
  - `vim.fn.executable(...)`
  - `vim.fn.has("win32")`
- Use `pcall` for optional features/extensions.
- Do not silently ignore critical failures unless fallback behavior is intentional.

### Plugin spec conventions
Preferred key ordering for readability:
1. plugin repo string
2. load triggers (`event`, `cmd`, `keys`, `ft`)
3. `dependencies`
4. `opts`
5. `config`
Prefer `opts = { ... }` for declarative setup; use `config = function()` when imperative logic is needed.

### Keymaps and autocmds
- Use `vim.keymap.set(...)` and include `desc`.
- Scope mappings to buffers where appropriate (especially on LSP attach).
- Create augroups before registering autocmds.
- Keep callbacks small; extract helpers when logic grows.

### Comments
- Keep comments short and purposeful.
- Avoid obvious comments that restate code.
- Preserve useful instructional comments already present.

### Avoid
- Avoid new globals unless truly necessary.
- Avoid unrelated plugin reordering.
- Avoid broad keybinding changes unless requested.
- Do not edit `lazy-lock.json` unless intentionally updating plugin versions.

## Validation Checklist For Agents
Run applicable checks before finishing:
```bash
stylua init.lua lua/
nvim --headless +qa
nvim --headless "+checkhealth" +qa
```
For plugin-related changes, also run:
```bash
nvim --headless "+Lazy! restore" +qa
```

## Maintenance Note
When conventions change (formatting, tests, CI, Cursor/Copilot rules), update this file in the same PR.
