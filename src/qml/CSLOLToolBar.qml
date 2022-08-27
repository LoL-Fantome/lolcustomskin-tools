import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

ToolBar {
    id: cslolToolBar

    property bool isBussy: false
    property var profilesModel: []
    property alias profilesCurrentIndex: profilesComboBox.currentIndex
    property alias profilesCurrentName: profilesComboBox.currentText
    property alias menuButtonHeight: mainMenuButton.height
    property alias enableAllState: enableAllCheckbox.checkState
    property alias enableAllChecked: enableAllCheckbox.checked


    signal openSideMenu()
    signal saveProfileAndRun(bool run)
    signal stopProfile()
    signal loadProfile()
    signal newProfile()
    signal removeProfile()

    RowLayout {
        id: toolbarRow
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        ToolButton {
            id: mainMenuButton
            text: "\uf013"
            font.family: "FontAwesome"
            onClicked: cslolToolBar.openSideMenu()
            ToolTip {
                text: qsTr("Open settings dialog")
                visible: parent.hovered
            }
        }
        ComboBox {
            id: profilesComboBox
            Layout.fillWidth: true
            currentIndex: 0
            enabled: !isBussy
            model: cslolToolBar.profilesModel
            ToolTip {
                text: qsTr("Select a profile to save, load or remove")
                visible: parent.hovered
            }
        }
        ToolButton {
            id: heartButton
            text: "\uf004"
            font.family: "FontAwesome"
            onClicked: {
                Qt.openUrlExternally("https://github.com/morilli")
            }
        }
        CheckBox {
            id: enableAllCheckbox
            enabled: !isBussy
            tristate: true
            checkState: Qt.PartiallyChecked
            nextCheckState: function() {
                return checkState === Qt.Checked ? Qt.Unchecked : Qt.Checked
            }
            ToolTip {
                text: qsTr("Enable all mods")
                visible: parent.hovered
            }
        }
        ToolButton {
            text: qsTr("Save")
            onClicked: cslolToolBar.saveProfileAndRun(false)
            enabled: !isBussy
            ToolTip {
                text: qsTr("Save enabled mods for selected profile")
                visible: parent.hovered
            }
        }
        ToolButton {
            text: qsTr("Load")
            onClicked: cslolToolBar.loadProfile()
            enabled: !isBussy
            ToolTip {
                text: qsTr("Load enabled mods for selected profile")
                visible: parent.hovered
            }
        }
        ToolButton {
            text: qsTr("Delete")
            onClicked: cslolToolBar.removeProfile()
            enabled: !isBussy
            ToolTip {
                text: qsTr("Delete selected profile")
                visible: parent.hovered
            }
        }
        ToolButton {
            text: qsTr("New")
            onClicked: cslolToolBar.newProfile()
            enabled: !isBussy
            ToolTip {
                text: qsTr("Create new profile")
                visible: parent.hovered
            }
        }
        ToolButton {
            text: window.patcherRunning ? qsTr("Stop") : qsTr("Run")
            onClicked: {
                if (window.patcherRunning) {
                    cslolToolBar.stopProfile()
                } else {
                    cslolToolBar.saveProfileAndRun(true)
                }
            }
            enabled: !isBussy || window.patcherRunning
            ToolTip {
                text: qsTr("Runs patcher for currently selected mods")
                visible: parent.hovered
            }
        }
    }
}
