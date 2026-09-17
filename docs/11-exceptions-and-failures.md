# 11 — Exceptions and Failures

Every cubit caught `Object`, threw it away, and emitted an error state
with nothing in it. Whatever went wrong, the screen said "Something went
wrong" — the same words for a dead server, a typo'd url, and a phone in
airplane mode.

## Two types, not one

Naming a cause and phrasing it are different jobs, so they are different
classes. `AppException` is what the data layer throws: an error code and
no text. `Failure` is what the UI reads: text and nothing else.

The codes are ours, not HTTP's — `NOT_FOUND` is our word, `404` is the
server's, and they are mapped rather than equated.

`AppException` is sealed and split in two, because only a refusal from
the server has a status code. `ServerException` carries one as a
required `int`, and `GeneralException` has none at all — so the field is
never null where it belongs and never there where it does not. That
holds because a `ServerException` is only built once a real status code
has been read off the response.

## Two hops

```
DioException → mapAppException → AppException → mapFailure → Failure
```

`mapAppException` is the only place that imports Dio. `mapFailure`
switches on the code alone, and an unnamed one falls through to the
generic message rather than failing to build.

## Interfaces, not the internet

`ConnectivityInterceptor` rejects a request before it is sent when no
interface is up, instead of waiting out a 15-second timeout.

It cannot promise more. `Connectivity` reports which interface is up —
wifi, cellular, none — not whether anything is reachable through it.
Wifi on a router with no line still passes, goes out, and fails as a
socket error, where the mapping names it. A shortcut for the certain
case, never the guarantee.

## Still not solved

The cubits still call the network directly and read an untyped `Map`,
and each one builds its own `ApiClient`.
