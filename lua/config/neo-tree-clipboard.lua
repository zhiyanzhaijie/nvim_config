-- neo-tree 跨实例剪贴板功能（复制/剪切/粘贴）
local M = {}

-- 配置
local config = {
  cache_file = vim.fn.expand("~/.cache/nvim/neo-tree-copy"),
}

-- 确保缓存目录存在
local function ensure_cache_dir()
  local cache_dir = vim.fn.fnamemodify(config.cache_file, ":h")
  if vim.fn.isdirectory(cache_dir) == 0 then
    vim.fn.mkdir(cache_dir, "p")
  end
end

-- 保存路径到缓存文件（包含操作类型）
local function save_to_cache(path, operation)
  ensure_cache_dir()
  local file = io.open(config.cache_file, "w")
  if file then
    -- 格式: operation|path
    file:write(operation .. "|" .. path)
    file:close()
    return true
  end
  return false
end

-- 从缓存文件读取路径和操作类型
local function read_from_cache()
  if vim.fn.filereadable(config.cache_file) == 1 then
    local file = io.open(config.cache_file, "r")
    if file then
      local content = file:read("*all")
      file:close()
      if content and content ~= "" then
        content = content:gsub("%s+$", "")
        local operation, path = content:match("^([^|]+)|(.+)$")
        if operation and path then
          return path, operation
        end
      end
    end
  end
  return nil, nil
end

-- 复制文件/文件夹路径
function M.copy_path(path)
  if save_to_cache(path, "copy") then
    local filename = vim.fn.fnamemodify(path, ":t")
    vim.notify(string.format("已复制: %s", filename))
  else
    vim.notify("复制失败: 无法写入缓存文件", vim.log.levels.ERROR)
  end
end

-- 剪切文件/文件夹路径
function M.cut_path(path)
  if save_to_cache(path, "cut") then
    local filename = vim.fn.fnamemodify(path, ":t")
    vim.notify(string.format("已剪切: %s", filename))
  else
    vim.notify("剪切失败: 无法写入缓存文件", vim.log.levels.ERROR)
  end
end

-- 获取复制的路径和操作类型
function M.get_copied_info()
  local path, operation = read_from_cache()
  
  if path and (vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1) then
    return path, operation
  end
  
  return nil, nil
end

-- 粘贴操作（会清空缓存）
function M.paste(target_dir)
  local copy_path, operation = M.get_copied_info()
  
  if not copy_path then
    vim.notify("没有复制或剪切的文件或文件夹", vim.log.levels.WARN)
    return false
  end
  
  local source_name = vim.fn.fnamemodify(copy_path, ":t")
  local target_path = target_dir .. "/" .. source_name
  
  -- 检查目标是否已存在
  if vim.fn.filereadable(target_path) == 1 or vim.fn.isdirectory(target_path) == 1 then
    local confirm = vim.fn.confirm(
      "目标 '" .. source_name .. "' 已存在，是否覆盖？",
      "&Yes\n&No",
      2
    )
    if confirm ~= 1 then
      return false
    end
  end
  
  -- 执行操作（复制或移动）
  local cmd
  local action_name
  
  if operation == "cut" then
    -- 剪切（移动）
    action_name = "移动"
    cmd = string.format("mv '%s' '%s'", copy_path:gsub("'", "'\\''"), target_path:gsub("'", "'\\''"))
  else
    -- 复制
    action_name = "复制"
    if vim.fn.isdirectory(copy_path) == 1 then
      cmd = string.format("cp -r '%s' '%s'", copy_path:gsub("'", "'\\''"), target_path:gsub("'", "'\\''"))
    else
      cmd = string.format("cp '%s' '%s'", copy_path:gsub("'", "'\\''"), target_path:gsub("'", "'\\''"))
    end
  end
  
  local result = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify("成功" .. action_name .. "到: " .. target_path)
    -- 粘贴完成后清空缓存
    M.clear_copied_path()
    return true
  else
    vim.notify(action_name .. "失败: " .. result, vim.log.levels.ERROR)
    return false
  end
end

-- 清除复制的路径
function M.clear_copied_path()
  if vim.fn.filereadable(config.cache_file) == 1 then
    vim.fn.delete(config.cache_file)
  end
end

-- 获取配置
function M.get_config()
  return config
end

-- 设置配置
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

return M
