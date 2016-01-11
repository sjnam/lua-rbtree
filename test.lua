local rbtree = require "rbtree"
local floyd = require "floyd"


local tree = rbtree.new()

local node
local arr = floyd.sample(10000, 1000000)
for _, v in ipairs(arr) do
   -- io.write(string.format("[%3d] ", v))
   tree:insert(v)
   -- tree:visit()
end

print("INSERT OK")

local idx = floyd.shuffle(10000)
for _, v in ipairs(idx) do
   -- io.write(string.format("[%3d] ", arr[v]))
   tree:delete(arr[v])
   -- tree:visit()
end

print("DELETE OK")

