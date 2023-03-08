local typedefs = require "kong.db.schema.typedefs"

return {
  name = "cookies-to-headers",
  fields = {
    {
      -- this plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      config = {
        type = "record",
        fields = {
          {
            cookie_name = {
              type = "string",
              default = "SESSION"
            },
          },
          {
            header_name = {
              type = "string",
              default = "Authorization"
            }
          }
        }
      }
    }
  }
}
