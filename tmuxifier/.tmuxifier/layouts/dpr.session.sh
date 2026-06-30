session_root "~/dev/php/DPR-API"
if initialize_session "dpr"; then
  new_window "be"
  run_cmd "nvim ."
  split_h 20          # vertical divider — nvim(80%) | right(20%)
  select_pane 1
  run_cmd "php -S localhost:9000 -t public"
  split_v 50          # horizontal divider inside right pane — php(50%) / idle(50%)
  select_pane 2
  # idle
  
  new_window "db"
  run_cmd "nvim -c ':DBUI'"

  new_window "claude"
  #idle

  select_window 0
fi
finalize_and_go_to_session
