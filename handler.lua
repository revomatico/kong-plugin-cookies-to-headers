local CookieToHeaders = require("kong.plugins.base_plugin"):extend()

function CookieToHeaders:new()
    CookieToHeaders.super.new(self, "cookies-to-headers")
end

function CookieToHeaders:access(plugin_conf)
    CookieToHeaders.super.access(self)
    local cookie = require "resty.cookie"

    local ck = cookie:new()
    local oauthToken, err = ck:get(plugin_conf.cookie_name)

    if not oauthToken then
        ngx.log(ngx.ERR, err)
    else
        if plugin_conf.header_name == "" then
          ngx.req.set_header("Authorization", "Bearer " .. oauthToken)
        else
          ngx.req.set_header(plugin_conf.header_name, oauthToken)
        end
    end
end

CookieToHeaders.PRIORITY = 900

return CookieToHeaders
