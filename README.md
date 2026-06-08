# nvim-luaref

Add a reference for builtin Lua functions, extracting both text and formatting from [the Lua 5.1 Reference Manual](https://www.lua.org/manual/5.1/manual.html).

All text referring to implementing Lua into a host C program has largely been removed.

For example:

```vim
:help lua_reference_toc
:help math.pi
:help coroutine.yield
```

Script generated documentation for Lua 5.1 in languages: `en`, `de`, `es`, and `pt`.

---

## Installation

For lazy.nvim:

```lua
{
  'DrKJeff16/nvim-luaref',
  lazy = false,
  build = 'make',
}
```
