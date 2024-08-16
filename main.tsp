import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;

@service({
  title: "Pet Store",
})
@server("https://example.com", "Single server endpoint")
namespace PetStore;

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

model CommonParameters {
  @header
  requestID: string;

  @query
  locale?: string;

  @header
  clientVersion?: string;
}

@route("/pets")
namespace Pets {
  @get
  op listPets(...CommonParameters): {
    @body pets: Pet[];
  };

	@get
  op getPet(@path petId: int32, ...CommonParameters): {
    @body pet: Pet;
  } | {
    @body error: NotFoundError;
  };

	@post
  op createPet(@body pet: Pet, ...CommonParameters): {
    @statusCode statusCode: 201;
    @body newPet: Pet;
  } | {
    @statusCode statusCode: 400;
    @body error: ValidationError;
  };

	@put
  op updatePet(@path petId: int32, @body pet: Pet, ...CommonParameters):
    | {
        @body updatedPet: Pet;
      }
    | {
        @body error: NotFoundError;
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | InternalServerErrorResponse;

  @delete
  op deletePet(@path petId: int32, ...CommonParameters): {
    @statusCode statusCode: 204;
  } | {
    @body error: NotFoundError;
  };
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
