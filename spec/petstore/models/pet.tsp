using TypeSpec.Http;

namespace PetStore;

model Pet {
  id: int32;

  @minLength(1)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;

  kind: PetType;
}

model PetFilter {
  name?: string;
  age?: int32;
  kind?: PetType;
}

alias petSortKey = "name" | "age";
