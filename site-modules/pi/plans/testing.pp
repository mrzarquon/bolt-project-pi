plan pi::testing (
  TargetSpec $nodes,
) {

  run_task('pi::gem_puppet', $nodes)

  apply_prep($nodes)

  $reports = apply ($nodes) {
    notify {'hello':}
  }
  $reports.each |$report| {
    notice("Node: ${report.target.name} Report: ${report.report}")
  }
}
