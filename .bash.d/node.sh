_node_complete() {
  local cur_word options
  cur_word="${COMP_WORDS[COMP_CWORD]}"
  if [[ "${cur_word}" == -* ]] ; then
    COMPREPLY=( $(compgen -W '--enable-source-maps --input-type --print --trace-sync-io --http-parser --no-warnings --experimental-vm-modules --force-context-aware --expose-internals --experimental-worker --experimental-import-meta-resolve --experimental-report --experimental-wasi-unstable-preview1 --no-deprecation --heapsnapshot-signal --no-force-async-hooks-checks --report-on-signal --heap-prof-dir --inspect-port --no-node-snapshot --perf-prof-unwinding-info --debug-brk --trace-tls --experimental-loader --tls-max-v1.2 --jitless --track-heap-objects --perf-prof --experimental-modules --huge-max-old-generation-size --trace-deprecation --eval --perf-basic-prof-only-functions --disallow-code-generation-from-strings --stack-trace-limit --experimental-repl-await --prof-process --trace-uncaught --inspect-brk-node --node-memory-debug --max-old-space-size --redirect-warnings --abort-on-uncaught-exception --report-signal --pending-deprecation --tls-min-v1.2 --tls-min-v1.0 --insecure-http-parser --security-revert --use-openssl-ca --tls-cipher-list --interpreted-frames-native-stack --cpu-prof-name --report-filename --experimental-abortcontroller --openssl-config --experimental-policy --icu-data-dir --diagnostic-dir --report-on-fatalerror --report-uncaught-exception --experimental-json-modules --trace-sigint --trace-exit --debug-arraybuffer-allocations --trace-atomics-wait --trace-event-file-pattern --require --experimental-top-level-await --use-bundled-ca --interactive --completion-bash --perf-basic-prof --harmony-top-level-await --v8-pool-size --tls-min-v1.1 --napi-modules --zero-fill-buffers --disable-proto --heap-prof-name --frozen-intrinsics --conditions --use-largepages --max-http-header-size --trace-event-categories --report-dir --v8-options --preserve-symlinks --test-udp-no-try-send --title --report-compact --experimental-wasm-modules --check --inspect --trace-warnings --throw-deprecation --version --cpu-prof --verify-base-objects --policy-integrity --debug --inspect-publish-uid --heap-prof --help --heap-prof-interval --cpu-prof-interval --preserve-symlinks-main --unhandled-rejections --tls-min-v1.3 --tls-max-v1.3 --inspect-brk --experimental-specifier-resolution --cpu-prof-dir --tls-keylog --debug-port --inspect= -r --debug= --debug-brk= -i --inspect-brk= --loader --prof-process --inspect-brk-node= -c -e --print <arg> -pe --trace-events-enabled -v --security-reverts --es-module-specifier-resolution -h -p --report-directory' -- "${cur_word}") )
    return 0
  else
    COMPREPLY=( $(compgen -f "${cur_word}") )
    return 0
  fi
}
complete -o filenames -o nospace -o bashdefault -F _node_complete node node_g
