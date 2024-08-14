#include <AppKit/AppKit.h>

class AppDelegate : public NS::ApplicationDelegate
{
public:
    virtual ~AppDelegate();

    NS::Menu* createMenuBar();

    virtual void applicationWillFinishLaunching(NS::Notification* notification) override;
    virtual void applicationDidFinishLaunching(NS::Notification* notification) override;
    virtual bool applicationShoudlTerminateAfterLastWindowClosed(NS::Application* sender) override;

private:

};
