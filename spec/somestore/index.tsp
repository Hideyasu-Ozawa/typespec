// import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;

@service({
  title: "Some Store",
})
@server("https://example.com/somesotre", "Single server endpoint")
namespace SomeStore;

@route("/some")
namespace Some {
  @get
  op listSomes(): {
    @body pets: Pet[];
  };
}

model Pet {
  id: int32;

  @minLength(1)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;
}
