local dap = require("dap")

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = {"dap", "-l", "127.0.0.1:${port}"},
  }
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  -- command = "/home/kris/.local/share/nvim/mason/bin/OpenDebugAD7",
  command = "gdb",
  -- args = {"-i", "dap"},
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    miDebuggerPath = '/usr/local/bin/gdb',
    stopAtEntry = false,
  },
  -- {
    -- name = 'Attach to gdbserver :1234',
    -- type = 'cppdbg',
    -- request = 'launch',
    -- MIMode = 'gdb',
    -- miDebuggerServerAddress = 'localhost:1234',
    -- miDebuggerPath = '/usr/local/bin/gdb',
    -- cwd = '${workspaceFolder}',
    -- environment = {
    --   {
    --     name = "config",
    --     value = "Debug",
    --   }
    -- },
    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,
    -- setupCommands = {
    --   {
    --     text = '-enable-pretty-printing',
    --     description =  'enable pretty printing',
    --     ignoreFailures = false
    --   },
    -- },
  -- },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
