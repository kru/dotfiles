local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    },
    ["<F1>"] = {
      "<cmd> DapStepOver <CR>",
      "Step continue"
    },
    ["<F2>"] = {
      "<cmd> DapContinue <CR>",
      "Step continue"
    },
  },
}

return M
