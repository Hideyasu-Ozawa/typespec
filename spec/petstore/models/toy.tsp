using TypeSpec.Versioning;

namespace PetStore;

@added(Versions.v2)
model Toy {
  id: int32;
  name: string;
}
