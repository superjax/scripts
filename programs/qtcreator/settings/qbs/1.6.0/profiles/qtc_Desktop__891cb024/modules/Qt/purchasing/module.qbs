import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "Purchasing"
    Depends { name: "Qt"; submodules: ["core"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/home/ultron/Qt/5.7/gcc_64/lib/libQt5Core.so.5.7.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5Purchasing"
    libNameForLinkerRelease: "Qt5Purchasing"
    libFilePathDebug: ""
    libFilePathRelease: "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Purchasing.so.5.7.0"
    cpp.defines: ["QT_PURCHASING_LIB"]
    cpp.includePaths: ["/home/ultron/Qt/5.7/gcc_64/include", "/home/ultron/Qt/5.7/gcc_64/include/QtPurchasing"]
    cpp.libraryPaths: ["/home/ultron/Qt/5.7/gcc_64/lib"]
    
}
