import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "PacketProtocol"
    Depends { name: "Qt"; submodules: ["core-private", "qml-private"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: ["/home/ultron/Qt/5.7/gcc_64/lib/libQt5Qml.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Network.so.5.7.0", "/home/ultron/Qt/5.7/gcc_64/lib/libQt5Core.so.5.7.0", "pthread"]
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5PacketProtocol"
    libNameForLinkerRelease: "Qt5PacketProtocol"
    libFilePathDebug: ""
    libFilePathRelease: "/home/ultron/Qt/5.7/gcc_64/lib/libQt5PacketProtocol.a"
    cpp.defines: ["QT_PACKETPROTOCOL_LIB"]
    cpp.includePaths: ["/home/ultron/Qt/5.7/gcc_64/include", "/home/ultron/Qt/5.7/gcc_64/include/QtPacketProtocol", "/home/ultron/Qt/5.7/gcc_64/include/QtPacketProtocol/5.7.0", "/home/ultron/Qt/5.7/gcc_64/include/QtPacketProtocol/5.7.0/QtPacketProtocol"]
    cpp.libraryPaths: ["/home/ultron/Qt/5.7/gcc_64/lib", "/home/ultron/Qt/5.7/gcc_64/lib"]
    isStaticLibrary: true
}
