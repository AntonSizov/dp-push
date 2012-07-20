-module(apns_tests).
-author('Yura Zhloba <yzh44yzh@gmail.com>').

-include("types.hrl").
-include_lib("eunit/include/eunit.hrl").

wrap_to_json_test() ->
    ?assertEqual(<<"{\"aps\":{}}">>, apns:wrap_to_json(#apns_msg{})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\"}}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello"})),
    ?assertEqual(<<"{\"aps\":{\"badge\":\"25\"}}">>,
     		 apns:wrap_to_json(#apns_msg{badge = 25})),
    ?assertEqual(<<"{\"aps\":{\"sound\":\"default\"}}">>,
     		 apns:wrap_to_json(#apns_msg{sound = default})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"sound\":\"hello\"}}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", sound = "hello"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"badge\":\"12\",\"sound\":\"hello\"}}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", badge = 12, sound = "hello"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"badge\":\"1\"}}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", badge = 1})),
    ?assertEqual(<<"{\"aps\":{\"badge\":\"15\",\"sound\":\"default\"}}">>,
		 apns:wrap_to_json(#apns_msg{badge = 15, sound = "default"})),
    ?assertEqual(<<"{\"aps\":{},\"d\":\"123\"}">>, apns:wrap_to_json(#apns_msg{data = "123"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\"},\"d\":\"hhh\"}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", data = "hhh"})),
    ?assertEqual(<<"{\"aps\":{\"badge\":\"25\"},\"d\":\"xxx\"}">>,
     		 apns:wrap_to_json(#apns_msg{badge = 25, data = "xxx"})),
    ?assertEqual(<<"{\"aps\":{\"sound\":\"default\"},\"d\":\"123\"}">>,
     		 apns:wrap_to_json(#apns_msg{sound = default, data = "123"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"sound\":\"hello\"},\"d\":\"123\"}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", sound = "hello", data = "123"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"badge\":\"12\",\"sound\":\"hello\"},\"d\":\"123\"}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", badge = 12, sound = "hello", data = "123"})),
    ?assertEqual(<<"{\"aps\":{\"alert\":\"Hello\",\"badge\":\"1\"},\"d\":\"123\"}">>,
		 apns:wrap_to_json(#apns_msg{alert = "Hello", badge = 1, data = "123"})),
    ?assertEqual(<<"{\"aps\":{\"badge\":\"15\",\"sound\":\"default\"},\"d\":\"123\"}">>,
		 apns:wrap_to_json(#apns_msg{badge = 15, sound = "default", data = "123"})),
    ok.
