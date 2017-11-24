local rbtree = require "lib.rbtree"

-- Floyd's random permutation generator
local function permgen (m, n)
   local s, head = {}
   for j = n-m+1, n do
      local t = math.random(j)
      if not s[t] then
         head = { key = t, next = head }
         s[t] = head
      else
         local curr = { key = j, next = s[t].next }
         s[t].next = curr
         s[j] = curr
      end
   end

   s = {}
   while head do
      table.insert(s, head.key)
      head = head.next
   end
   
   return s
end


math.randomseed(os.time())

local MAXN = 10000

local n = tonumber(arg[1]) or 10
if n > MAXN then n = MAXN end

local tree = rbtree.new()

local node
local arr = permgen(n, MAXN)


for _, v in ipairs(arr) do
   tree:insert(v)
end

print("OK insert")

local s = {}
for v in tree:walk() do
   s[#s+1] = v
   io.write(v, " ")
end
print("\n")

for _, v in ipairs(s) do
   print("OK delete", v)
   tree:delete(v)
end

