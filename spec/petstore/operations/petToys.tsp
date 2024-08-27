using TypeSpec.Http;
using TypeSpec.Versioning;

namespace PetStore.Pets;
@tag("PetToys")
@route("/{petId}/toys")
namespace PetToys {
  @added(Versions.v2)
  @opExample(#{ returnType: #{ toys: toys } })
  @get
  op listToys(@path petId: int32, ...CommonParameters): {
    @body toys: Toy[];
  };

  @added(Versions.v2)
  @post
  @useAuth(BearerAuth)
  op createToy(@path petId: int32, @body toy: Toy, ...CommonParameters): {
    @statusCode statusCode: 201;
    @body newToy: Toy;
  };

  @added(Versions.v2)
  @put
  @useAuth(BearerAuth)
  op updateToy(
    @path petId: int32,
    @path toyId: int32,
    @body toy: Toy,
    ...CommonParameters,
  ): {
    @body updatedToy: Toy;
  };

  @added(Versions.v2)
  @delete
  @useAuth(BearerAuth)
  op deleteToy(@path petId: int32, @path toyId: int32, ...CommonParameters): {
    @statusCode statusCode: 204;
  };
}
