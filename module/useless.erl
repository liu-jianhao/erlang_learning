-module(useless).
-export([add/2, hello/0, greet_and_add_two/1, use_macro/2]).
-define(sub(X,Y), X-Y).

add(A,B) ->
    A + B.

%% 显示欢迎语
%% io:format/1 是标准的文本输出函数
hello() ->
    io:format("Hello world!~n").

greet_and_add_two(X) ->
    hello(),
    add(X, 2).

use_macro(X, Y) ->
    ?sub(X, Y).

