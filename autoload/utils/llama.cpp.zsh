llama-qwen() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF -c 262144 --host 0.0.0.0 --port 8080\n\n"
  echo "------------"
  llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF -c 262144 --host 0.0.0.0 --port 8080
}

llama-Qwen3.6-27B-GGUF:UD-Q8_K_XL() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-27B-GGUF:Q4_K_M -c 262144 --host 0.0.0.0 --port 8080"
  echo "------------"
  llama-server -hf unsloth/Qwen3.6-27B-GGUF:Q4_K_M -c 262144 --host 0.0.0.0 --port 8080
}

llama-qwen3.6-27b-Q8_K_XL() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-27B-GGUF:UD-Q8_K_XL -c 262144 --host 0.0.0.0 --port 8080"
  echo "------------"
  llama-server -hf unsloth/Qwen3.6-27B-GGUF:UD-Q8_K_XL -c 262144 --host 0.0.0.0 --port 8080
}

llama-qwen3.6-35b-Q8_K_XL() {
  echo "Running llama.cpp with the following command:\n"
  echo "llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q8_K_XL -c 262144 --host 0.0.0.0 --port 8080"
  echo "------------"
  llama-server -hf unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q8_K_XL -c 262144 --host 0.0.0.0 --port 8080
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

# for general tasks
# https://unsloth.ai/docs/models/qwen3.6#qwen3.6-27b
llama-test-general() {

  echo "Running llama.cpp with the following command:\n"
  echo "
  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 1.0 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 1.5 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080"
  echo "------------"

  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 1.0 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 1.5 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080
}

# for coding tasks
# https://unsloth.ai/docs/models/qwen3.6#qwen3.6-27b
llama-test-code() {

  echo "Running llama.cpp with the following command:\n"
  echo "
  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 0.6 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 0.0 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080"
  echo "------------"

  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 0.6 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 0.0 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080
}

llama-test-code-np2() {

  echo "Running llama.cpp with the following command:\n"
  echo "
  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 0.6 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 0.0 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080 \
      --parallel 2"
  echo "------------"

  llama-server \
      -hf unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL \
      --temp 0.6 \
      --top-p 0.95 \
      --top-k 20 \
      --presence-penalty 0.0 \
      --min-p 0.00 \
      -c 262144 \
      --host 0.0.0.0 \
      --port 8080 \
      --parallel 2
}
