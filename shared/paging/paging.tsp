// TODO: TとUの関係
model PagingRequest<T,U extends string> {
  page?: int32 = 1;
  perPage?: int32 = 10;
  filter?: T;
  sortKey?: U;
  sortOder?:"asc" | "desc";
}

model PagingResponse<T> {
  items: T[];
  totalItems: int32;
  totalPages: int32;
  currentPage: int32;
  pageSize: int32;
}

