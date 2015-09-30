-module(data_activity_list).
-export([get/1]).
get(ids) -> [1,2,60];
get(1) -> [];
get(2) -> [];
get(60) -> [];
get(_) -> undefined.