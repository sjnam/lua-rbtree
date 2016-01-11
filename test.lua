local floyd = require "floyd"
local rbtree = require "rbtree"

local ipairs = ipairs
local permgen = floyd.permgen
local shuffle = floyd.shuffle


local N = 10000

local tree = rbtree.new()

local node
local arr = permgen(N, 1000000)
for _, v in ipairs(arr) do
   tree:insert(v)
end

print("INSERT OK")

local idx = shuffle(N)
for _, v in ipairs(idx) do
   tree:delete(arr[v])
end

print("DELETE OK")

