-module(calc).
-export([rpn/1, rpn_test/0]).

rpn(L) when is_list(L) ->
    % lists:foldl/3 对表达式中的每个操作符和操作数要应用给定函数
    % string:tokens/2 的作用是将字符串根据分隔符得到数据项列表
    [Res] = lists:foldl(fun rpn/2, [], string:tokens(L, " ")),
    Res.

% 当遇到“+”时，会从栈顶部取两个数值，并把它们相加的结果放回栈中
rpn("+", [N1, N2|S]) -> [N2+N1|S];
rpn("-", [N1,N2|S]) -> [N2-N1|S];
rpn("*", [N1,N2|S]) -> [N2*N1|S];
rpn("/", [N1,N2|S]) -> [N2/N1|S];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("ln", [N|S])    -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];
rpn("sum", Stack)   -> [lists:sum(Stack)];
rpn("prod", Stack)  -> [lists:foldl(fun erlang:'*'/2, 1, Stack)];
rpn(X, Stack) -> [read(X)|Stack].

%% 将字符串转换成整数或浮点数
read(N) ->
    case string:to_float(N) of
        % 如果不是浮点数
        {error, no_float} -> list_to_integer(N);
        {F, _} -> F
    end.


%% 简单的测试
rpn_test() ->
    5 = rpn("2 3 +"),
    87 = rpn("90 3 -"),
    -4 = rpn("10 4 3 + 2 * -"),
    -2.0 = rpn("10 4 3 + 2 * - 2 /"),
    ok = try
        rpn("90 34 12 33 55 66 + * - +")
    catch
        error:{badmatch,[_|_]} -> ok
    end,
    4037 = rpn("90 34 12 33 55 66 + * - + -"),
    8.0 =  rpn("2 3 ^"),
    true = math:sqrt(2) == rpn("2 0.5 ^"),
    true = math:log(2.7) == rpn("2.7 ln"),
    true = math:log10(2.7) == rpn("2.7 log10"),
    50 = rpn("10 10 10 20 sum"),
    10.0 = rpn("10 10 10 20 sum 5 /"),
    1000.0 = rpn("10 10 20 0.5 prod"),
    ok.
