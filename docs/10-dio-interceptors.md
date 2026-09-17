# 10 — Dio + Interceptors

Two problems, and only the second one is about `http`.

## The cubit owns the request

Each of the three cubits builds its own url, calls the client, and
decodes the body. `https://dummyjson.com` is written three times, the
query is concatenated rather than escaped, and nothing sets a timeout.

`ApiClient` takes all of it: one class owning the connection, the base
url and the timeouts, turning a path and a query map into a decoded
body. It exposes `get` alone, because reading is all this app does.

## http has no interceptors

Nothing above is a reason to leave `http` — `ApiClient` could have
wrapped it just as well. This is the reason.

`http` has no point where code runs on every request: no hook before one
is sent, none when a response arrives, none when a call fails. Anything
belonging to all traffic — a header, a retry, a log — gets repeated at
each call site instead.

Dio has that hook. An `Interceptor` has `onRequest`, `onResponse` and
`onError`, and Dio runs them around every call:

```dart
@override
void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  debugLog('$_name onRequest', _requestLines(options).join('\n'));
  handler.next(options);
}
```

`handler.next` passes the call along; forgetting it stalls the request
forever.

`LoggingInterceptor` is the only one here: method, uri, headers and body
from all three hooks, through `debugLog`, which keeps it out of release
builds. Auth, retries and error mapping are the same hook, other
branches.

## Still not solved

The cubits catch `Object` and throw away the `DioException` that says
what actually failed. They still call the network directly and read an
untyped `Map`. And each one builds its own `ApiClient`, which builds its
own `Dio` — three clients, no way to hand either a fake.
