local json_decode = vim.fn.json_decode
if vim.json then
  json_decode = vim.json.decode
end

local function split_string(str, split)
  local parts = {}
  for token in string.gmatch(str, "[^".. split .."]+") do
    table.insert(parts, token)
  end
  return parts
end

local function get_ext(filename)
  local parts = split_string(filename, ".")
  local len = #(parts)
  return parts[len]
end

local function load_launch_json()
  local launch_exists = vim.api.nvim_eval("filereadable('.vscode/launch.json')")
  if ~launch_exists then
    print("no launch.json found")
    return nil
  end
  local f = io.open(".vscode/launch.json", "r")
  local conf = json_decode(f:read())

  f:close()
  return conf
end

local function debug()
  load_launch_json()
  local dap = require 'dap'
  local filename = vim.api.nvim_eval("expand('%:p')")
  if filename == "" then
    print("No file opened")
    return
  end
  local ext = get_ext(filename)
  local adapter = dap.adapters[ext]
  if adapter == nil then
    print("No adapter found for file type: " .. ext)
  end

  -- dap.launch(adapter)
end

return {
  debug = debug,
}

