local status, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not status then
  print("tokyonight is not found!")
  return
end
