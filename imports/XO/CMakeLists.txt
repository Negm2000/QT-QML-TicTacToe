### This file is automatically generated by Qt Design Studio.
### Do not change

qt_add_library(XO STATIC)
set_source_files_properties(Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
    )

qt6_add_qml_module(XO
    URI "XO"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Constants.qml
        DirectoryFontLoader.qml
        EventListModel.qml
        EventListSimulator.qml
)
