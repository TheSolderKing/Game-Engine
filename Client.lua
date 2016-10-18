Client = class()

function Client:init(port)
    -- you can accept and set parameters here
    socket = require("socket")
    self.port = port
    self.ip = self:getLocalIp()
    self.connected = false
    self.socket = socket.udp()
end

function Client:getLocalIp()
    local randomSocket = socket.udp()
    randomSocket:setpeername("localhost",5000)
    local ip = randomSocket:getsockname()
    randomSocket:close()
    return ip
end

function Client:joinGame(ip,usr)
    self.socket:setpeername(ip,self.port)
    self.socket:send(string.format('u:<%s>m:<connect>',usr))
    --self.socket:send("connect")
    self.socket:settimeout(0)
end

function Client:update()
    self:receive()
end

function Client:send(data)
    self.socket:send(data)
end

function Client:receive()
    local data,ip_,port_ = self.socket:receive()
    
    if data then
        if not self.connected and data == "Heo" then
                self.peer = {ip = ip_,port = port_}
                self.connected = true
        else
            f = received or function(d) print(d) end
            f(data)
        end
    end
end
