llama-qwen() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF -c 262144 --host 0.0.0.0 --port 8080\n\n"
  echo "------------"
  llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF -c 262144 --host 0.0.0.0 --port 8080
}

# https://news.ycombinator.com/item?id=47863217#47865140
# https://simonwillison.net/2026/Apr/22/qwen36-27b/
llama-qwen-benob() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-27B-GGUF:Q4_K_M --no-mmproj --fit on -np 1 -c 262144 --cache-ram 4096 -ctxcp 2 --jinja --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0 --reasoning on --chat-template-kwargs '{\"preserve_thinking\": true}' --host 0.0.0.0 --port 8080\n\n"
  echo "------------"

  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:Q4_K_M \
      --no-mmproj \
      --fit on \
      -np 1 \
      -c 262144 \
      --cache-ram 4096 -ctxcp 2 \
      --jinja \
      --temp 0.6 \
      --top-p 0.95 \
      --top-k 20 \
      --min-p 0.0 \
      --presence-penalty 0.0 \
      --repeat-penalty 1.0 \
      --reasoning on \
      --chat-template-kwargs '{"preserve_thinking": true}' \
      --host 0.0.0.0 \
      --port 8080
}
