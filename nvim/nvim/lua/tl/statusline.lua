-- vim: set foldmethod=marker foldlevel=0 nomodeline:
local has_heirline, heriline = pcall(require, 'heirline')
local _, conditions = pcall(require, 'heirline.conditions')
local _, utils = pcall(require, 'heirline.utils')

local M = {}

-------------------------------------------------------------------------------
-- Utils {{{1
-------------------------------------------------------------------------------
--- Blend two rgb colors using alpha
---@param color1 string | number first color
---@param color2 string | number second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
local function blend(color1, color2, alpha)
  ---@diagnostic disable-next-line: cast-local-type
  color1 = type(color1) == 'number' and string.format('#%06x', color1)
    or color1
    or '#000000'
  ---@diagnostic disable-next-line: cast-local-type
  color2 = type(color2) == 'number' and string.format('#%06x', color2)
    or color2
    or '#000000'
  local r1, g1, b1 = color1:match('#(%x%x)(%x%x)(%x%x)')
  local r2, g2, b2 = color2:match('#(%x%x)(%x%x)(%x%x)')
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return '#'
    .. string.format('%02x', math.min(255, math.max(r, 0)))
    .. string.format('%02x', math.min(255, math.max(g, 0)))
    .. string.format('%02x', math.min(255, math.max(b, 0)))
end

---@diagnostic disable-next-line: param-type-mismatch
local function dim(color, n)
  return blend(color, '#000000', n)
end

-------------------------------------------------------------------------------
-- Components {{{1
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- ViMode {{{2
-------------------------------------------------------------------------------
local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = 'N',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'V',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'T',
    },
    mode_colors = {
      n = 'red',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan',
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple',
      R = 'orange',
      r = 'orange',
      ['!'] = 'red',
      t = 'red',
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
      return ' %2(' .. self.mode_names[self.mode] .. '%)'
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_colors[mode], bold = true }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allows the statusline to be re-evaluated when entering operator-pending mode
    update = {
      'ModeChanged',
      pattern = '*:*',
      callback = vim.schedule_wrap(function()
        vim.cmd('redrawstatus')
      end),
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    return ' %2(' .. self.mode_names[self.mode] .. '%)'
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode], bold = true }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- This is not required in any way, but it's there, and it's a small
  -- performance improvement.
  update = { 'ModeChanged' },
}
-------------------------------------------------------------------------------
-- ViMode {{{2
-------------------------------------------------------------------------------
local WorkDir = {
  on_click = {
    callback = function()
      vim.cmd('lua require("tfm").open()')
    end,
    name = 'heirline_workdir',
  },
  init = function(self)
    self.icon = (vim.fn.haslocaldir(0) == 1 and 'l' or 'g') .. ' ' .. ' '
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
  end,
  hl = { fg = 'blue', bold = true },

  flexible = 1,

  {
    -- evaluates to the full-length path
    provider = function(self)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. self.cwd .. trail .. ' '
    end,
  },
  {
    -- evaluates to the shortened path
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. cwd .. trail .. ' '
    end,
  },
  {
    -- evaluates to "", hiding the component
    provider = '',
  },
}

local HelpFileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
    if self.lfilename == '' then
      self.lfilename = '[No Name]'
    end
  end,
  hl = { fg = utils.get_highlight('Directory').fg },

  flexible = 2,

  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(
      filename,
      extension,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
    if self.lfilename == '' then
      self.lfilename = '[No Name]'
    end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    if not conditions.width_percent_below(#self.lfilename, 0.25) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
    end
  end,
  hl = { fg = utils.get_highlight('Directory').fg },
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = '[+]',
    hl = { fg = 'green' },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = '',
    hl = { fg = 'orange' },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = 'cyan', bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  { provider = '%<' }
)

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= 'utf-8' and enc:upper()
  end,
}
local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= 'unix' and fmt:upper()
  end,
}
local FileSize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return fsize .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
  end,
}
local FileLastModified = {
  -- did you know? Vim is full of functions!
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date('%c', ftime)
  end,
}

-------------------------------------------------------------------------------
-- Cursor position: Ruler and ScrollBar {{{2
-------------------------------------------------------------------------------
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = '%7(%l/%3L%):%2c %P',
}

local ScrollBar = {
  static = {
    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    -- sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'blue', bg = 'bright_bg' },
}

-------------------------------------------------------------------------------
-- LSP {{{2
-------------------------------------------------------------------------------
local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider = function()
    local names = {}
    for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return ' [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = 'green', bold = true },
  on_click = {
    name = 'heirline_LSP',
    callback = function()
      vim.schedule(function()
        vim.cmd('LspInfo')
      end)
    end,
  },
}

-- Full nerd (with icon colors and clickable elements)!
-- works in multi window, but does not support flexible components (yet ...)
local Navic = {
  condition = function()
    return require('nvim-navic').is_available()
  end,
  static = {
    -- create a type highlight map
    type_hl = {
      File = 'Directory',
      Module = '@include',
      Namespace = '@namespace',
      Package = '@include',
      Class = '@structure',
      Method = '@method',
      Property = '@property',
      Field = '@field',
      Constructor = '@constructor',
      Enum = '@field',
      Interface = '@type',
      Function = '@function',
      Variable = '@variable',
      Constant = '@constant',
      String = '@string',
      Number = '@number',
      Boolean = '@boolean',
      Array = '@field',
      Object = '@type',
      Key = '@keyword',
      Null = '@comment',
      EnumMember = '@field',
      Struct = '@structure',
      Event = '@keyword',
      Operator = '@operator',
      TypeParameter = '@type',
    },
    -- bit operation dark magic, see below...
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require('nvim-navic').get_data() or {}
    local children = {}
    -- create a child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos =
        self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        { provider = d.icon, hl = self.type_hl[d.type] },
        {
          -- escape `%`s (elixir) and buggy default separators
          provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
          -- highlight icon only or location name as well
          -- hl = self.type_hl[d.type],

          on_click = {
            -- pass the encoded position through minwid
            minwid = pos,
            callback = function(_, minwid)
              -- decode
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(
                vim.fn.win_getid(winnr),
                { line, col }
              )
            end,
            name = 'heirline_navic',
          },
        },
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, { provider = ' > ', hl = { fg = 'bright_fg' } })
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self.child = self:new(children, 1)
  end,
  -- evaluate the children containing navic components
  provider = function(self)
    return self.child:eval()
  end,
  hl = { fg = 'gray' },
  update = 'CursorMoved',
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
    warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
    info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity.ERROR,
    })
    self.warnings = #vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity.WARN,
    })
    self.hints = #vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity.HINT,
    })
    self.info = #vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity.INFO,
    })
    self.total = self.errors + self.hints + self.hints + self.info
    self.separator = (self.total > 1 and ' ') or ''
  end,

  update = { 'DiagnosticChanged', 'BufEnter' },

  { provider = '![' },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0
        and (self.error_icon .. self.errors .. self.separator)
    end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self)
      return self.warnings > 0
        and (self.warn_icon .. self.warnings .. self.separator)
    end,
    hl = { fg = 'diag_warn' },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. self.separator)
    end,
    hl = { fg = 'diag_info' },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = 'diag_hint' },
  },
  on_click = {
    callback = function()
      require('trouble').toggle({ mode = 'document_diagnostics' })
      -- or
      -- vim.diagnostic.setqflist()
    end,
    name = 'heirline_diagnostics',
  },
  { provider = ']' },
}

local git_icons = tl.style.icons.git

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    ---@diagnostic disable-next-line: undefined-field
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,

  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd('lua require("tl.term").toggleTig()')
      end, 100)
    end,
    name = 'heirline_git',
    update = false,
  },

  hl = { fg = 'orange' },

  {
    provider = function(self)
      return string.format('%s %s', git_icons.branch, self.status_dict.head)
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '(',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      local separator = (self.status_dict.removed or 0)
              + (self.status_dict.changed or 0)
            > 0
          and ' '
        or ''
      return count > 0
        and (string.format('%s %s', git_icons.add, count) .. separator)
    end,
    hl = { fg = 'git_add' },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      local separator = (self.status_dict.added or 0)
              + (self.status_dict.changed or 0)
            > 0
          and ' '
        or ''
      return count > 0
        and (string.format('%s %s', git_icons.remove, count) .. separator)
    end,
    hl = { fg = 'git_del' },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (string.format('%s %s', git_icons.diff, count))
    end,
    hl = { fg = 'git_change' },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ')',
  },
}

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = 'SPELL ',
  hl = { bold = true, fg = 'orange' },
}
local SearchCount = {
  condition = function()
    return vim.v.hlsearch ~= 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    if search == nil then
      return
    else
      return string.format(
        '%d/%d',
        search.current,
        math.min(search.total, search.maxcount)
      )
    end
  end,
}

local MacroRec = {
  condition = function()
    return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
  end,
  provider = ' ',
  hl = { fg = 'orange', bold = true },
  utils.surround({ '[', ']' }, nil, {
    provider = function()
      return vim.fn.reg_recording()
    end,
    hl = { fg = 'green', bold = true },
  }),
  update = { 'RecordingEnter', 'RecordingLeave' },
}

vim.opt.showcmdloc = 'statusline'
local ShowCmd = {
  condition = function()
    return vim.o.cmdheight == 0
  end,
  provider = ':%3.5(%S%)',
}

Navic = { flexible = 3, Navic, { provider = '' } }
ViMode = utils.surround({ '', '' }, 'bright_bg', { ViMode })

local Align = { provider = '%=' }
local Space = { provider = ' ' }

-------------------------------------------------------------------------------
-- StatusLines {{{1
-------------------------------------------------------------------------------
local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
      filetype = { '^git.*' },
    })
  end,
  FileType,
  { provider = '%q' },
  Space,
  HelpFileName,
  Align,
}

local DefaultStatusline = {
  ViMode,
  SearchCount,
  Space,
  Spell,
  WorkDir,
  FileNameBlock,
  { provider = '%<' },
  Space,
  Git,
  Space,
  Diagnostics,
  Align,
  Navic,
  Align,
  LSPActive,
  Space,
  FileType,
  { flexible = 3, { Space, FileEncoding }, { provider = '' } },
  Space,
  Ruler,
  Space,
  ScrollBar,
}

local InactiveStatusline = {
  condition = conditions.is_not_active,
  { hl = { fg = 'gray', force = true }, WorkDir },
  FileNameBlock,
  { provider = '%<' },
  Align,
}

-- local TerminalStatusline = {
--   condition=function() return conditions.buffer_matches({buftype={'terminal'}}) end,
--   hl={bg='dark_red'},
--   -- {condition=conditions.is_active, ViMode, Space},
--   FileType,
--   Space,
--   TerminalName,
--   Align
-- }

local StatusLines = {

  hl = function()
    if conditions.is_active() then
      return 'StatusLine'
    else
      return 'StatusLineNC'
    end
  end,

  static = {
    mode_colors = {
      n = 'red',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan', -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple', -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = 'orange',
      r = 'orange',
      ['!'] = 'red',
      t = 'green',
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or 'n'
      return self.mode_colors[mode]
    end,
  },

  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { 'terminal' },
        filetype = { 'packer' },
      })
    end,
    init = function()
      vim.opt_local.statusline = nil
    end,
  },
  -- GitStatusline,
  SpecialStatusline,
  -- TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

local TerminalName = {
  -- we could add a condition to check that buftype == 'terminal'
  -- or we could do that later (see #conditional-statuslines below)
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
    return ' ' .. tname
  end,
  hl = { fg = 'blue', bold = true },
}
local CloseButton = {
  condition = function()
    return not vim.bo.modified
  end,
  -- a small performance improvement:
  -- re register the component callback only on layout/buffer changes.
  update = { 'WinNew', 'WinClosed', 'BufEnter' },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'gray' },
    on_click = {
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      callback = function(_, minwid)
        vim.api.nvim_win_close(minwid, true)
      end,
      name = 'heirline_winbar_close_button',
    },
  },
}
-- Use it anywhere!
local WinBarFileName = utils.surround({ '', '' }, 'bright_bg', {
  hl = function()
    if not conditions.is_active() then
      return { fg = 'gray', force = true }
    end
  end,
  FileNameBlock,
  Space,
  CloseButton,
})

-------------------------------------------------------------------------------
-- WinBar {{{1
-------------------------------------------------------------------------------

local WinBars = {
  fallthrough = false,
  { -- A special winbar for terminals
    condition = function()
      return conditions.buffer_matches({ buftype = { 'terminal' } })
    end,
    utils.surround({ '', '' }, 'dark_red', {
      FileType,
      Space,
      TerminalName,
    }),
  },
  WinBarFileName,
}

-------------------------------------------------------------------------------
-- Tabline {{{1
-------------------------------------------------------------------------------
local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. '. '
  end,
  hl = 'Comment',
}

local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == '' and '[No Name]'
      or vim.fn.fnamemodify(filename, ':t')
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, 'modified')
    end,
    provider = '[+]',
    hl = { fg = 'green' },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, 'modifiable')
        or vim.api.nvim_buf_get_option(self.bufnr, 'readonly')
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, 'buftype') == 'terminal' then
        return '  '
      else
        return ''
      end
    end,
    hl = { fg = 'orange' },
  },
}

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return 'TabLineSel'
    elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      return { fg = 'gray' }
    else
      return 'TabLine'
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if button == 'm' then -- close on mouse middle click
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = 'heirline_tabline_buffer_callback',
  },
  TablineBufnr,
  FileIcon,
  TablineFileName,
  TablineFileFlags,
}

local TablineCloseButton = {
  condition = function(self)
    -- return not vim.bo[self.bufnr].modified
    return not vim.api.nvim_buf_get_option(self.bufnr, 'modified')
  end,
  { provider = ' ' },
  { --  ✗    
    provider = '󰅙 ',
    hl = { fg = 'gray' },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_buf_delete(minwid, { force = false })
        vim.cmd.redrawtabline()
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}

local TablinePicker = {
  condition = function(self)
    return self._show_picker
  end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ':t')
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      label = bufname:sub(i, i)
      if i > #bufname then
        break
      end
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self)
    return self.label
  end,
  hl = { fg = 'red', bold = true },
}

vim.keymap.set('n', 'gbp', function()
  local tabline = require('heirline').tabline
  ---@diagnostic disable-next-line: undefined-field
  local buflist = tabline._buflist[1]
  buflist._picker_labels = {}
  buflist._show_picker = true
  vim.cmd.redrawtabline()
  local char = vim.fn.getcharstr()
  local bufnr = buflist._picker_labels[char]
  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  end
  buflist._show_picker = false
  vim.cmd.redrawtabline()
end)

local TablineBufferBlock = utils.surround({ '', '' }, function(self)
  if self.is_active then
    return utils.get_highlight('TabLineSel').bg
  else
    return utils.get_highlight('TabLine').bg
  end
end, { TablinePicker, TablineFileNameBlock, TablineCloseButton })

-- this is the default function used to retrieve buffers
local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, 'buflisted')
  end, vim.api.nvim_list_bufs())
end

-- initialize the buflist cache
local buflist_cache = {}

-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
vim.api.nvim_create_autocmd({ 'VimEnter', 'UIEnter', 'BufAdd', 'BufDelete' }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end

      -- check how many buffers we have and set showtabline accordingly
      if #buflist_cache > 1 then
        vim.o.showtabline = 2 -- always
      elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
        vim.o.showtabline = 1 -- only when #tabpages > 1
      end
    end)
  end,
})

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = ' ', hl = { fg = 'gray' } },
  { provider = ' ', hl = { fg = 'gray' } },
  -- out buf_func simply returns the buflist_cache
  function()
    return buflist_cache
  end,
  -- no cache, as we're handling everything ourselves
  false
)

local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = function(self)
    if not self.is_active then
      return 'TabLine'
    else
      return 'TabLineSel'
    end
  end,
}

local TabpageClose = { provider = ' %999X󰅙 %X', hl = 'TabLine' }

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = '%=' },
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == 'NvimTree' then
      self.title = 'NvimTree'
      return true
      -- elseif vim.bo[bufnr].filetype == "TagBar" then
      --     ...
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(' ', pad) .. title .. string.rep(' ', pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return 'TablineSel'
    else
      return 'Tabline'
    end
  end,
}

local TabLine = { TabLineOffset, BufferLine, TabPages }

-------------------------------------------------------------------------------
-- Setup {{{1
-------------------------------------------------------------------------------
function M.setup()
  if not has_heirline then
    return
  end

  local tokyonight_colors = require('tokyonight.colors').setup({
    style = 'storm',
  })
  local colors = {
    bright_bg = tokyonight_colors.bg,
    bright_fg = tokyonight_colors.fg,
    red = tokyonight_colors.red,
    dark_red = tokyonight_colors.red1,
    green = tokyonight_colors.green,
    blue = tokyonight_colors.blue,
    gray = tokyonight_colors.comment,
    orange = tokyonight_colors.orange,
    purple = tokyonight_colors.purple,
    cyan = tokyonight_colors.cyan,
    diag_warn = tokyonight_colors.warning,
    diag_error = tokyonight_colors.error,
    diag_hint = tokyonight_colors.hint,
    diag_info = tokyonight_colors.info,
    git_del = tokyonight_colors.git.delete,
    git_add = tokyonight_colors.git.add,
    git_change = tokyonight_colors.git.change,
  }
  heriline.load_colors(colors)

  heriline.setup({
    statusline = StatusLines,
    winbar = WinBars,
    tabline = TabLine,
    opts = {
      -- if the callback returns true, the winbar will be disabled for that window
      -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
      disable_winbar_cb = function(args)
        return conditions.buffer_matches({
          buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
          filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
        }, args.buf)
      end,
    },
  })

  vim.api.nvim_create_augroup('Heirline', { clear = true })

  -- vim.o.showtabline = 2;
  vim.cmd(
    [[au Heirline FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]
  )

  vim.api.nvim_create_autocmd('User', {
    pattern = 'HeirlineInitWinbar',
    callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains({
        'prompt',
        'nofile',
        'help',
        'quickfix',
      }, vim.bo[buf].buftype)
      local filetype = vim.tbl_contains({
        'gitcommit',
        'fugitive',
        'Trouble',
        'packer',
      }, vim.bo[buf].filetype)
      if buftype or filetype then
        vim.opt_local.winbar = nil
      end

      if vim.bo[buf].filetype == 'gitcommit' then
        vim.o.showtabline = 0
        vim.o.tabline = ''
      else
        vim.o.showtabline = 2
      end
    end,
    group = 'Heirline',
  })

  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      utils.on_colorscheme(colors)
    end,
    group = 'Heirline',
  })
end

return M
