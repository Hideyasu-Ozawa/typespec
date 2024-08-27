using TypeSpec.Http;

namespace PetStore;

@route("/pets")
namespace Pets {
  @tag("Pet")
  @doc("""
    Get status info for the service.
    The status includes the current version of the service.
    The status value may be one of:
    - `ok`: the service is operating normally
    - `degraded`: the service is operating in a degraded state
    - `down`: the service is not operating
    """)
  @get
  @opExample(#{ returnType: #{ statusCode: 200, body: pets } })
  op listPets(...CommonParameters): PetListResponse | BadRequestResponse;

  @tag("Pet")
  @get
  @opExample(#{ returnType: #{ statusCode: 200, body: pet } })
  op getPet(
    @path petId: int32,
    @header ifMatch?: string,
  ): PetResponse | PetNotFoundResponse | BadRequestResponse;

  @tag("Pet")
  @useAuth(BearerAuth)
  @post
  op createPet(@body pet: Pet): PetCreatedResponse | PetErrorResponse;

  @tag("Pet")
  @useAuth(BearerAuth)
  @put
  op updatePet(@path petId: int32, @body pet: Pet):
    | PetResponse
    | PetNotFoundResponse
    | PetUnauthorizedResponse
    | InternalServerErrorResponse;

  @tag("Pet")
  @useAuth(BearerAuth)
  @delete
  op deletePet(
    @path petId: int32,
  ): PetNotFoundResponse | PetSuccessResponse | PetUnauthorizedResponse;
}
