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
    randomSocket:setpeername("192.168.1.100",5000)
    local ip = randomSocket:getsockname()
    randomSocket:close()
    return ip
end

function Client:joinGame(ip)
    self.socket:setsockname(ip,port)
    self.socket:send("connect")
end

function Client:update()
    self:receive()
end

function Client:receive()
    local data,ip_,port_ = self.socket:receive()
    
    if data then
        if not self.connected and data == "connect" then
                self.peer = {ip = ip_,port = port_}
                self.connected = true
        else
            f = received or function(d) print(d) end
            f(data)
        end
    end
end
