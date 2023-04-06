generate_hcl "README.tfdoc.hcl" {
  content {
    section {
      title   = "TODO"
      toc     = true
      content = <<-END
        This will be generated per module also
      END
    }
  }
}
