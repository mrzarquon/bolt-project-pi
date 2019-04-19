plan pi::bootstrap (
  TargetSpec $nodes,
) {

  add_to_group($nodes, 'raspberrybootstrap')

  run_task('pi::gem_puppet', $nodes)

  $result = run_plan('pi::testing', $nodes)

  notice("result: ${result}")

}
