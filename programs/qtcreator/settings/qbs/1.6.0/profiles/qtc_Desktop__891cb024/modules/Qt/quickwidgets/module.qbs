import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "QuickWidgets"
    Depends { name: "Qt"; submodules: ["core", "gui", "qml", "quick", "widgets"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/home/ultron/Qt/5.7/gcc_64/lib/libQt5Quick.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Qml.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Widgets.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Gui.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Network.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Core.so.5.7.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5QuickWidgets"
    libNameForLinkerRelease: "Qt5QuickWidgets"
    libFilePathDebug: ""
    libFilePathRelease: "/home/ultron/Qt/5.7/gcc_64/lib/libQt5QuickWidgets.so.5.7.0"
    cpp.defines: ["QT_QUICKWIDGETS_LIB"]
    cpp.includePaths: ["/home/ultron/Qt/5.7/gcc_64/include", "/home/ultron/Qt/5.7/gcc_64/include/QtQuickWidgets"]
    cpp.libraryPaths: ["/usr/lib64", "/home/ultron/Qt/5.7/gcc_64/lib", "/home/ultron/Qt/5.7/gcc_64/lib"]
    
}
