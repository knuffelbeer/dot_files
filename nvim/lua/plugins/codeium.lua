return {
{
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  lazy = false,
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set('i', '<M-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
--    vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
--    vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
}}
