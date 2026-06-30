session_root "~/dev/js/DPR-fe"
if initialize_session "dpr-fe"; then
  new_window "app"
  run_cmd "nvim ."
  split_h 30          # vertical divider — nvim(80%) | right(20%)
  select_pane 1
  run_cmd "npm run dev"
  split_v 50          # horizontal divider inside right pane — npm(50%) / idle(50%)
  select_pane 2
  # idle

  new_window "db"
  run_cmd "nvim -c ':DBUI'"

  select_window 0
fi
finalize_and_go_to_session
