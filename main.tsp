import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Pet Store",
})
@server("https://example.com", "Single server endpoint")
@versioned(Versions)
// File-level namespaces
namespace PetStore;

enum Versions {
  v1: "1.0",
  v2: "2.0",
}

model Pet {
  id: int32;

  @minLength(1)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;

  kind: petType;
}

enum petType {
  dog: "dog",
  cat: "cat",
  fish: "fish",
  bird: "bird",
  reptile: "reptile",
}

@added(Versions.v2)
model Toy {
  id: int32;
  name: string;
}

model CommonParameters {
  @header
  requestID: string;

  @query
  locale?: string;

  @header
  clientVersion?: string;
}

model PetListResponse {
  ...OkResponse;
  ...Body<Pet[]>;
}

model PetResponse {
  ...OkResponse;
  ...Body<Pet>;
}

model PetCreatedResponse {
  ...CreatedResponse;
  ...Body<Pet>;
}

model PetErrorResponse {
  ...BadRequestResponse;
  ...Body<ValidationError>;
}

model PetNotFoundResponse {
  ...NotFoundResponse;
  ...Body<NotFoundError>;
}

model PetUnauthorizedResponse {
  ...UnauthorizedResponse;
  ...Body<ValidationError>;
}

model PetSuccessResponse {
  ...OkResponse;
  ...Body<string>;
}
@route("/pets")
namespace Pets {
  @doc("""
    Get status info for the service.
    The status includes the current version of the service.
    The status value may be one of:
    - `ok`: the service is operating normally
    - `degraded`: the service is operating in a degraded state
    - `down`: the service is not operating
    """)
  @tag("Status")
  @route("/status")
  @get
  op listPets(...CommonParameters): PetListResponse | BadRequestResponse;

  @get
  op getPet(
    @path petId: int32,
    @header ifMatch?: string,
  ): PetResponse | PetNotFoundResponse | BadRequestResponse;

  @useAuth(BearerAuth)
  @post
  op createPet(@body pet: Pet): PetCreatedResponse | PetErrorResponse;

  @useAuth(BearerAuth)
  @put
  op updatePet(@path petId: int32, @body pet: Pet):
    | PetResponse
    | PetNotFoundResponse
    | PetUnauthorizedResponse
    | InternalServerErrorResponse;

  @useAuth(BearerAuth)
  @delete
  op deletePet(
    @path petId: int32,
  ): PetNotFoundResponse | PetSuccessResponse | PetUnauthorizedResponse;

  @route("{petId}/toys")
  namespace Toys {
    @added(Versions.v2)
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
}

@error
model NotFoundError {
  code: "NOT_FOUND";
  message: string;
}

@error
model ValidationError {
  code: "VALIDATION_ERROR";
  message: string;
  details: string[];
}

@error
model InternalServerError {
  code: "INTERNAL_SERVER_ERROR";
  message: string;
}

model InternalServerErrorResponse {
  @statusCode statusCode: 500;
  @body error: InternalServerError;
}
