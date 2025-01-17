local CookieToHeaders = {
  VERSION = "1.2.0",
  PRIORITY = 1000,
}

function CookieToHeaders:access(plugin_conf)
    local cookie = require "resty.cookie"

    local ck = cookie:new()
    local cookieValue, err = ck:get(plugin_conf.cookie_name)

    if not cookieValue then
        ngx.log(ngx.ERR, err)
    else
        if string.lower(plugin_conf.header_name) == "authorization" then
          ngx.req.set_header("Authorization", "Bearer " .. cookieValue)
        else
          ngx.req.set_header(plugin_conf.header_name, cookieValue)
        end
    end
end

return CookieToHeaders
