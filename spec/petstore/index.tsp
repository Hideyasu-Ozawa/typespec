import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "@typespec/versioning";

import "./enums/petType.tsp";
import "./enums/versions.tsp";
import "./examples/operations/pets.tsp";
import "./examples/operations/toys.tsp";
import "./models/commonParam.tsp";
import "./models/pet.tsp";
import "./models/toy.tsp";
import "./models/response.tsp";
import "./operations/pets.tsp"; // petsに関する操作を記述。tagと同一
import "./operations/petToys.tsp"; // petToysに関する操作を記述。tagと同一

using TypeSpec.Http;
using TypeSpec.Versioning;

// API仕様書の宣言
@service({
  title: "Pet Store",
})
@server("https://example.com/petstore", "Single server endpoint")
@versioned(Versions)
namespace PetStore;
