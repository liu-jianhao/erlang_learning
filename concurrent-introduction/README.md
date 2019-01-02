# 并发入门

## 创建进程
```erlang
10> G = fun(X) -> timer:sleep(10), io:format("~p~n", [X]) end.
#Fun<erl_eval.6.99386804>
11> [spawn(fun() -> G(X) end) || X <- lists:seq(1, 10)].
[<0.90.0>,<0.91.0>,<0.92.0>,<0.93.0>,<0.94.0>,<0.95.0>,
 <0.96.0>,<0.97.0>,<0.98.0>,<0.99.0>]
1
2
10
3
4
5
6
7
8
9
```

`self()`返回pid，`!`是消息传递原语，`flush()`查看当前邮箱的内容
```erlang
17> self().
<0.102.0>
18> exit(self()).
** exception exit: <0.102.0>
19> self().
<0.108.0>
20> self() ! hello.
hello
21> flush().
Shell got hello
ok
```

## 简单应用
```erlang
1> c(dolphins).
dolphins.erl:2: Warning: export_all flag enabled - all functions will b
e exported
{ok,dolphins}
2> Dolphin = spawn(dolphins, dolphin1, []).
<0.67.0>
3> Dolphin ! "oh, hello dolphin!".
Heh, we're smarter than you humans.
"oh, hello dolphin!"
4> Dolphin ! fish.
fish
5> f(Dolphin).
ok
6> Dolphin = spawn(dolphins, dolphin1, []).
<0.72.0>
7> Dolphin ! fish.
So long and thanks for all the fish!
fish
```

```erlang
9> Dolphin2 = spawn(dolphins, dolphin2, []).
<0.77.0>
10> Dolphin2 ! {self(), do_a_flip}.
{<0.60.0>,do_a_flip}
11> flush().
Shell got "How about no?"
ok
```

```erlang
12> Dolphin3 = spawn(dolphins, dolphin3, []).
<0.81.0>
13> Dolphin3 ! Dolphin3 ! {self(), do_a_flip}.
{<0.60.0>,do_a_flip}
14> flush().
Shell got "How about no?"
Shell got "How about no?"
ok
15> Dolphin3 ! {self(), unknown_message}.
Heh, we're smarter than you humans.
{<0.60.0>,unknown_message}
16> Dolphin3 ! Dolphin3 ! {self(), fish}.
{<0.60.0>,fish}
17> flush().
Shell got "So long and thanks for all the fish!"
ok
```