--[[
   Copyleft (Ↄ) Soojin Nam

   Programming Pearls: a sample of brilliance
   Communications of the ACM, 
   Volume 30 Issue 9, Sept. 1987,  
   Pages 754-757 
--]]

local pairs = pairs
local randint = math.random
local insert = table.insert


-- set arguments
local maxn = 1000000000 -- 1,000,000,000

local function _set_args (m, n)
   if not m then
      return nil, "numeric arguments should be given."
   end
   local n = n or m
   if n > maxn then
      return nil, n.." should be less than "..maxn.."."
   elseif m > n then
      return nil, m.." should be less than or equal to "..n.."."
   end
   return m, n
end


-- module stuffs

local _M = {}


-- Floyd's random permutation generator
local function _rand_permgen (...)
   local m, n = _set_args(...)
   if not m then
      return nil, n
   end

   local s, head = {}
   for j = n-m+1, n do
      local t = randint(j)
      if not s[t] then
         -- prefix t to s
         head = { key = t, next = head }
         s[t] = head
      else
         -- insert j in s after t
         local curr = { key = j, next = s[t].next }
         s[t].next = curr
         s[j] = curr
      end
   end

   s = {}
   while head do
      insert(s, head.key)
      head = head.next
   end
   
   return s
end

_M.shuffle = _rand_permgen
_M.permgen = _rand_permgen

math.randomseed(os.time())

return _M

