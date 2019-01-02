-module(record).
-compile(export_all).
-include("record.hrl").

% 记录，本质上是元组
-record(robot, {
    name,
    type=industrial,
    hobbies,
    details=[]
}).

% 生成一个记录实例
first_robot() ->
    #robot{name="Mechatron",
    type=handmade,
    details=["Moved by a small man inside"]}.

car_factory(CorpName) ->
    #robot{name=CorpName, hobbies="building cars"}.


% 更新记录
repairman(Rob) ->
    Details = Rob#robot.details,
    NewRob = Rob#robot{details=["Repaired by repairman"|Details]},
    {repaired, NewRob}.

% 测试包含的头文件
included() -> #included{some_field="Some value"}.