# type
Erlang是一门动态类型语言，即不用声明变量的类型。

## 类型转换
``` erlang
1> erlang:list_to_integer("54").
54
2> erlang:integer_to_list(54).
"54"
3> erlang:list_to_integer("54.32").
** exception error: bad argument
     in function  list_to_integer/1
        called as list_to_integer("54.32")
6> erlang:list_to_float("54.32").
54.32
7> erlang:atom_to_list(true).
"true"
8> erlang:list_to_binary("hi there").
<<"hi there">>
9> erlang:binary_to_list(<<"hi therr">>).
"hi therr"
```
