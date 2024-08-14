#pragma once

namespace MTL
{
    class Device;
    class CommandQueue;
}

class Renderer
{
public:
    Renderer();
    virtual ~Renderer();
    
    void Draw();

private:
    MTL::Device* m_Device;
    MTL::CommandQueue* m_CommandQueue;
};
