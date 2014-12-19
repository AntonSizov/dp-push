-module(dp_push).
-author('Yura Zhloba <yzh44yzh@gmail.com>').

-behaviour(application).
-export([main/0, send/2, send_alert/2, send_badge/2, send_data/2, send_raw/2, remove_device_from_failed/1]).
-export([start/2, stop/1]).
-include("logger.hrl").
-include("types.hrl").

main() ->
    ssl:start(),
    application:start(dp_push),
    sync:go(),
    ok.

-spec(send(#apns_msg{}, device_token()) -> ok | {error, error()}).
send(#apns_msg{} = Msg, DeviceToken) ->
    dp_push_sender:send(Msg, DeviceToken).


-spec(send_alert(iolist(), device_token()) -> ok | {error, error()}).
send_alert(Alert, DeviceToken) ->
    send(#apns_msg{alert = Alert}, DeviceToken).


-spec(send_badge(integer(), device_token()) -> ok | {error, error()}).
send_badge(Badge, DeviceToken) ->
    send(#apns_msg{badge = Badge}, DeviceToken).


-spec(send_data(iolist(), device_token()) -> ok | {error, error()}).
send_data(Data, DeviceToken) ->
    send(#apns_msg{data = Data}, DeviceToken).

-spec(send_raw(iolist(), device_token()) -> ok | {error, error()}).
send_raw(Data, DeviceToken) ->
    dp_push_sender:send(Data, DeviceToken).


-spec(remove_device_from_failed(device_token()) -> ok).
remove_device_from_failed(DeviceToken) ->
    dp_push_sender:remove_device_from_failed(DeviceToken).


start(_StartType, _StartArgs) ->
    {ok, DetsFile} = application:get_env(failed_tokens_dets),
    {ok, Interval} = application:get_env(feedback_check_interval),
    {ok, AProps} = application:get_env(apns),
    {ok, CProps} = application:get_env(cert),
    Apns = #apns{host = proplists:get_value(host, AProps),
		 port = proplists:get_value(port, AProps),
		 feedback_host = proplists:get_value(feedback_host, AProps),
		 feedback_port = proplists:get_value(feedback_port, AProps)},
    Cert = #cert{certfile = proplists:get_value(certfile, CProps),
		 password = proplists:get_value(password, CProps)},
    ?WARN("Server started ~p ~p ~n", [Apns, Cert]),
    dp_push_sup:start_link({DetsFile, Interval, Apns, Cert}).


stop(_State) ->
    ok.
