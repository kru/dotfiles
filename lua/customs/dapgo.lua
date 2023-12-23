local dapgo = require("dap-go")

dapgo.setup {
  dap_configuration = {
    type = "go",
    name = "Attach remote",
    mode = "remote",
    request = "attach",
  },
  -- delve configurations
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = "${port}",
    args = {},
    build_flags = "",
  }
}
