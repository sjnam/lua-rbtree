# rbtree
Implementation fo red-black tree in lua.
The red-black tree code is based on the algorithm described in
the "Introduction to Algorithms" by Cormen, Leiserson and Rivest.

new
---
`syntax: rbt = rbtree.new()`

Create rbtree object.

tnode
---------
`syntax: node = rbt:tnode()`

Create rbtree node object.

walk
--------
`syntax: tab = rbt:walk()`

Visit all node in a rbtree by inorder tree walk and return array.

insert
----------
`syntax: rbt:insert(key)`

Insert a node into the rbtree

delete
----------
`syntax: rbt:delete(key)`

Delete the node of a key from the rbtree.

