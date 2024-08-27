using TypeSpec.Http;

namespace PetStore;

model CommonParameters {
  @header
  requestID: string;

  @query
  locale?: string;

  @header
  clientVersion?: string;
}
