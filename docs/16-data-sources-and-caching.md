# 16 — Data Sources and Caching

`RecipesRepositoryImpl` built urls, parsed models, and caught every
error. Three jobs, and no room for a fourth: there was nowhere to put a
second place the data could come from.

## The remote data source

`RecipesRemoteDataSource` takes the paths, the query parameters and the
parsing, and rethrows what Dio throws as a named `AppException`. The
repository keeps what was always its own: turning that into a `Failure`.

## The cache

drift over SQLite, with two tables:

```
cached_recipes         id + sort as the key, plus position
cached_recipe_details  the full record, keyed by id
```

**Two tables**, because the list returns six fields and the details
twelve. Merged, a list refresh would upsert its six over a full row and
drop the rest.

**A position column**, because `reviewCount` never reaches the client
and a stored `rating` goes stale. The cache remembers the order the
server chose instead of deriving it.

**A recipe stored twice**, once per sort. An earlier draft added a third
table to avoid that, and reading a page then took two queries and a
lookup map. Duplicated strings are cheaper.

## When the cache is read

Only after the network fails, and only for a first page.

A `loadMore` never falls back — the cache holds what is already on
screen, so answering from it would repeat recipes. A cached page reports
its own length as `total`, so the cubit's `recipes.length < total` makes
`hasMore` false and paging stops. No cubit changed in this branch.

Search has no fallback. The cache holds whatever this device scrolled
past, and the server searches ingredients and instructions too — three
results where there are twenty is worse than saying the request failed.

Two failures stay hidden: a failed write never turns a working request
into an error, and a cache that fails during a fallback says nothing the
network error does not.

## The images

`CachedNetworkImage` keeps the file and caps it at 1080px on disk and in
memory, so a photo is never stored or decoded larger than a phone shows.

## What got deleted

A `CacheService` sat between the data source and drift, meant to make
swapping the database a one-file change. It could not: its signatures
were written in `TableInfo` and `Expression`, so replacing drift would
have rewritten the interface anyway.

Branch 15 asked the same question about use cases and kept the empty
ones, because a cubit depending on one callable is a real seam. This hid
nothing, so it went.

## Still not solved

Every page builds a client, two data sources, a repository and a use
case by hand. `CacheDatabase` is `static` because three pages opening
the same file would not see each other's writes — a stand-in for the
dependency injection that comes next.
