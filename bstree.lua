--[[
   Copyleft (Ↄ) Soojin Nam

   Binary Search Tree
--]]

local tab_insert = table.insert


local function tnode (k)
   return { key = k }
end


local inorder_tree_walk
function inorder_tree_walk (s, x)
   if x then
      inorder_tree_walk (s, x.left)
      tab_insert(s, x.key)
      inorder_tree_walk (s, x.right)
   end
end


local function tree_search (x, k)
   while x and k ~= x.key do
      if k < x.key then
         x = x.left
      else
         x = x.right
      end
   end
   return x
end


local function tree_minimum (x)
   while x.left do
      x = x.left
   end
   return x
end


local function tree_maximum (x)
   while x.right do
      x = x.right
   end
   return x
end


local function tree_successor (x)
   if x.right then
      return tree_minimum(x.right)
   end
   local y = x.p
   while y and x == y.right do
      x = y
      y = y.p
   end
   return y
end


local function tree_insert (tree, z)
   local x, y = tree.root, nil
   while x do
      y = x
      if z.key < x.key then
         x = x.left
      else
         x = x.right
      end
   end
   z.p = y
   if not y then
      tree.root = z
   elseif z.key < y.key then
      y.left = z
   else
      y.right = z
   end
end


local function transplant (tree, u, v)
   if not u.p then
      tree.root = v
   elseif u == u.p.left then
      u.p.left = v
   else
      u.p.right = v
   end
   if v then
      v.p = u.p
   end
end


local function tree_delete (tree, z)
   if not z.left then
      transplant (tree, z, z.right)
   elseif not z.right then
      transplant (tree, z, z.left)
   else
      y = tree_minimum(z.right)
      if y.p ~= z then
         transplant(tree, y, y.right)
         y.right = z.right
         y.right.p = y
      end
      transplant(tree, z, y)
      y.left = z.left
      y.left.p = y
   end
end


local _M = { }

local mt = { __index = _M }


function _M.new ()
   return setmetatable({ root = nil }, mt)
end


function _M.tnode (self, k)
   return tnode(k)
end


function _M.walk (self)
   local s = {}
   inorder_tree_walk(s, self.root)
   return s
end


function _M.insert (self, k)
   local node
   if type(k) == "number" then
      node = tnode(k)
   else
      node = k
   end
   tree_insert(self, node)
end


function _M.delete (self, k)
   local z = tree_search(self, k)
   tree_delete(self, z)
end


return _M

