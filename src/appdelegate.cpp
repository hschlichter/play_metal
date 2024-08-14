#include "appdelegate.h"

AppDelegate::~AppDelegate()
{

}

NS::Menu* AppDelegate::createMenuBar()
{
    return nullptr;
}

void AppDelegate::applicationWillFinishLaunching(NS::Notification* notification)
{

}

void AppDelegate::applicationDidFinishLaunching(NS::Notification* notification)
{

}

bool AppDelegate::applicationShoudlTerminateAfterLastWindowClosed(NS::Application* sender)
{
    return false;
}
