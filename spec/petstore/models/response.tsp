using TypeSpec.Http;

namespace PetStore;

model PetResponse {
  ...OkResponse;
  ...Body<Pet>;
}

model PetListResponse {
  ...OkResponse;
  ...Body<Pet[]>;
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

model InternalServerErrorResponse {
  @statusCode statusCode: 500;
  @body error: InternalServerError;
}
