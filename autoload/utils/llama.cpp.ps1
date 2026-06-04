
# https://www.reddit.com/r/LocalLLaMA/comments/1sor55y/rtx_5070_ti_9800x3d_running_qwen3635ba3b_at_79_ts/?show=original
function llama-qwen-test {
  llama-server `
    -hf unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M `
    --fit on `
    --fit-ctx 128000 `
    --fit-target 512 `
    -np 1 `
    -fa on `
    -ctk q8_0 `
    -ctv q8_0 `
    --temp 0.6 `
    --top-p 0.95 `
    --top-k 20 `
    --min-p 0.0 `
    --presence-penalty 0.0 `
    --repeat-penalty 1.0 `
    --reasoning-budget -1 `
    --host 0.0.0.0 `
    --port 8033
}
