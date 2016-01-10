--[[
   Copyleft (Ↄ) Soojin Nam

   The red-black tree code is based on the algorithm described in
   the "Introduction to Algorithms" by Cormen, Leiserson and Rivest.
--]]


local RED = 1
local BLACK = 0


local inorder_tree_walk
function inorder_tree_walk (x, s)
   if x ~= s then
      inorder_tree_walk (x.left, s)
      io.write(x.key, " ")
      inorder_tree_walk (x.right, s)
   end
end


local function tree_minimum (x, s)
   while x.left ~= s do
      x = x.left
   end
   return x
end


local function tree_search (x, k, s)
   while x ~= s and k ~= x.key do
      if k < x.key then
         x = x.left
      else
         x = x.right
      end
   end
   return x
end


local function left_rotate(tree, x)
   local tnil = tree.sentinel
   
   local y = x.right
   x.right = y.left
   if y.left ~= tnil then
      y.left.p = x
   end
   y.p = x.p 
   if x.p == tnil then
      tree.root = y
   elseif x == x.p.left then
      x.p.left = y
   else
      x.p.right = y
   end
   y.left = x
   x.p = y
end


local function right_rotate(tree, x)
   local tnil = tree.sentinel
   
   local y = x.left
   x.left = y.right
   if y.right ~= tnil then
      y.right.p = x
   end
   y.p = x.p
   if x.p == tnil then
      tree.root = y
   elseif x == x.p.right then
      x.p.right = y
   else
      x.p.left = y
   end
   y.right = x
   x.p = y
end


local function insert (tree, z)
   local tnil = tree.sentinel

   local y = tnil
   local x = tree.root
   while x ~= tnil do
      y = x
      if z.key < x.key then
         x = x.left
      else
         x = x.right
      end
   end
   z.p = y
   if y == tnil then
      tree.root = z
   elseif z.key < y.key then
      y.left = z
   else
      y.right = z
   end
   y.left = tnil
   z.right = tnil
   z.color = RED

   -- insert-fixup
   while z.p.color == RED do
      if z.p == z.p.p.left then
         y = z.p.p.right
         if y.color == RED then
            z.p.color = BALCK
            y.color = BLACK
            z.p.p.color = RED
            z = z.p.p
         else
            if z == z.p.right then
               z = z.p
               left_rotate(tree, z)
            end
            z.p.color = BLACK
            z.p.p.color = RED
            right_rotate(tree, z.p.p)
         end
      else
         y = z.p.p.left
         if y.color == RED then
            z.p.color = BLACK
            y.color = BLACK
            z.p.p.color = RED
            z = z.p.p
         else
            if z == z.p.left then
               z = z.p
               right_rotate(tree, z)
            end
            z.p.color = BLACK
            z.p.p.color = RED
            left_rotate(tree, z.p.p)
         end
      end
   end
   tree.root.color = BLACK
end


local function transplant (tree, u, v)
   local tnil = tree.sentinel
   if u.p == tnil then
      tree.root = v
   elseif u == u.p.left then
      u.p.left = v
   else
      u.p.right = v
   end
   v.p = u.p
end


local function delete (tree, z)
   local x, w
   local tnil = tree.sentinel
   local y = z
   local y_original_color = y.color
   if z.left == tnil then
      x = z.right
      transplant(tree, z, z.right)
   elseif z.right == tnil then
      x = z.left
      transplant(tree, z, z.left)
   else
      y = tree_minimum(z.right, tnil)
      y_original_color = y.color
      x = y.right
      if y.p == z then
         x.p = y
      else
         transplant(tree, y, y.right)
         y.right = z.right
         y.right.p = y
      end
      transplant(tree, z, y)
      y.left = z.left
      y.left.p = y
      y.color = z.color

      if y_original_color == BLACK then
         -- delete-fixup
         while x ~= tree.root and x.color == BLACK do
            if x == x.p.left then
               w = x.p.right
               if w.color == RED then
                  w.color = BLACK
                  x.p.color = RED
                  left_rotate(tree, x.p)
                  w = x.p.right
               end
               if w.left.color == BLACK and w.right.color == BLACK then
                  w.color = RED
                  x = x.p
               else
                  if w.right.color == BLACK then
                     w.left.color = BLACK
                     w.color = RED
                     right_rotate(tree, w)
                     w = x.p.right
                  end
                  w.color = x.p.color
                  x.p.color = BLACK
                  w.right.color = BLACK
                  left_rotate(tree, x.p)
                  x = tree.root
               end
            else
               w = x.p.left
               if w.color == RED then
                  w.color = BLACK
                  x.p.color = RED
                  right_rotate(tree, x.p)
                  w = x.p.left
               end
               if w.left.color == BLACK and w.right.color == BLACK then
                  w.color = RED
                  x = x.p
               else
                  if w.left.color == BLACK then
                     w.right.color = BLACK
                     w.color = RED
                     left_rotate(tree, w)
                     w = x.p.left
                  end
                  w.color = x.p.color
                  x.p.color = BLACK
                  w.left.color = BLACK
                  right_rotate(tree, x.p)
                  x = tree.root
               end
            end
         end
         x.color = BLACK
      end
   end
end


local function rbtree_node (key, s)
   return  {
      key = key or 0,
      left = s,
      right = s,
      p = s,
      color = BLACK
   }
end


-- rbtree module stuffs

local _M = {}

local mt = { __index = _M }


function _M.new ()
   local sentinel = rbtree_node()
   sentinel.color = BLACK
   
   return setmetatable({ root = sentinel, sentinel = sentinel }, mt)
end


function _M.visit (self)
   inorder_tree_walk(self.root, self.sentinel)
   print()
end


function _M.insert (self, key)
   insert(self, rbtree_node(key, self.sentinel))
end


function _M.delete (self, key)
   local z = tree_search (self.root, key, self.sentinel)
   if z ~= self.sentinel then
      delete(self, z)
   end
end


return _M

