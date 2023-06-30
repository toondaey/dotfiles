require('custom')

vim.opt.exrc = true

local clock = os.clock
function Sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
