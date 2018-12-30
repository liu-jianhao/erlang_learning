-module(functions).
-compile(export_all).

head([H|_]) -> H.

second([_,X|_]) -> X.

same(X,X) ->
    true;   % 子函数用分号分隔
same(_,_) ->
    false.

% 缺点：传进来的元组的各种元素类型都会接受
valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
    io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n", [Date,Y,M,D]),
    io:format("The time tuple (~p) indicates: ~p/~p/~p,~n", [Time,H,Min,S]);
valid_time(_) ->
    io:format("Stop feeding me wrong data!~n").

% 卫语句
right_age(X) when X >= 16, X =< 104 ->
    true;
right_age(_) ->
    false.

% if语句
oh_god(N) ->
    if N =:= 2 -> might_succeed;
       true -> always_does     %% 这就是else
    end.

% case ... of语句
% 一个不重复集合的插入函数
insert(X,[]) ->
    [X];
insert(X,Set) ->
    case lists:member(X,Set) of % 检查X是否在集合中
        true -> Set;
        false -> [X|Set]
    end.
