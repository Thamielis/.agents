# {{AppName}}

## Run

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\src\Server.ps1 -Port {{Port}}
```

## Validate

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\Invoke-PodeToolSelfTest.ps1
```

## Notes

- Add endpoints in `src/Routes/`.
- Put expensive operations behind caching and test them with Pester.
