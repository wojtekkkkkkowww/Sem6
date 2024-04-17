on(b1,b2).
on(b2,b3).
on(b3,b4).
on(b4,b5).
above(Block1,Block2) :- on(Block1,Block2).
above(Block1,Block2) :- on(Block,Block2), above(Block1,Block).
