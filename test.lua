local rbtree = require "rbtree"

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


local N = 10000

local tree = rbtree.new()

local node
local arr = permgen(N, 1000000)
for _, v in ipairs(arr) do
   tree:insert(v)
end

print("INSERT OK")

local idx = permgen(N, N)
for _, v in ipairs(idx) do
   tree:delete(arr[v])
end

print("DELETE OK")

