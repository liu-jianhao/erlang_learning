# 高阶函数

## 匿名函数
```erlang
7> Fn = fun() -> a end.
#Fun<erl_eval.20.99386804>
8> Fn().
a
9> hhfuns:map(fun(X) -> X * 2 end, L).
[2,4,6,8,10]
10> hhfuns:map(fun(X) -> X / 2 end, L).
[0.5,1.0,1.5,2.0,2.5]
```

## 函数作用域和闭包
```erlang
a() ->
    Secret = "pony",
fun() -> Secret end.

b(F) ->
    "a/0's password is "++F().
```

```erlang
12> hhfuns:b(hhfuns:a()).
"a/0's password is pony"
```
当在`b/1`中执行这个匿名函数时，它仍然携带着`a/0`的作用域。


```erlang
13> math:pow(5,2).
25.0
14> Base = 2.
2
15> PowerOfTwo = fun(X) -> math:pow(Base, X) end.
#Fun<erl_eval.6.99386804>
16> hhfuns:map(PowerOfTwo, [1,2,3,4]).
[2.0,4.0,8.0,16.0]
```