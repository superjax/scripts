import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "Bluetooth"
    Depends { name: "Qt"; submodules: ["core"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/home/ultron/Qt/5.7/gcc_64/lib/libQt5DBus.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Core.so.5.7.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5Bluetooth"
    libNameForLinkerRelease: "Qt5Bluetooth"
    libFilePathDebug: ""
    libFilePathRelease: "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Bluetooth.so.5.7.0"
    cpp.defines: ["QT_BLUETOOTH_LIB"]
    cpp.includePaths: ["/home/ultron/Qt/5.7/gcc_64/include", "/home/ultron/Qt/5.7/gcc_64/include/QtBluetooth"]
    cpp.libraryPaths: ["/home/ultron/Qt/5.7/gcc_64/lib"]
    
}
