#include <MetalKit/MetalKit.h>

class Renderer;
namespace MTL
{
    class Device;
}

class ViewDelegate : public MTK::ViewDelegate
{
public:
    ViewDelegate(MTL::Device* device);
    virtual ~ViewDelegate() override;

    virtual void drawInMTKView(MTK::View* view) override;

private:
    Renderer* m_Renderer;
};
