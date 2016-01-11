local rbtree = require "rbtree"
local floyd = require "floyd"


local tree = rbtree.new()

local node
local arr = floyd.sample(100000, 1000000)
for _, v in ipairs(arr) do
   tree:insert(v)
end

print("INSERT OK")

local idx = floyd.shuffle(100000)
for _, v in ipairs(idx) do
   tree:delete(arr[v])
end

print("DELETE OK")

