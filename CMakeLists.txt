cmake_minimum_required(VERSION 3.1.0)

########## GENERAL PROJECT SETTINGS ##########

project ( ratflow-core NONE )
set( VERSION_MAJOR 1 )
set( VERSION_MINOR 0 )
set( VERSION_PATCH 0 )


################ INSTALLATION ################

set( CMAKE_PROJECT_NAME ratflow-core )


###### CACHED VARIABLES ######

# Set the system name like: cmake -DPACKAGE_SYSTEM_NAME="xenial-16.04" project
set(PACKAGE_SYSTEM_NAME "debian" CACHE STRING "Destination system release and version")

set(PACKAGE_SYSTEM_ARCH "amd64" CACHE STRING "Destination system architecture")


###### INSTALLATION PATHS ######

SET(MAIN_INSTALLATION_DIR "/usr/share/ratflow")


INSTALL(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/system/usr/
  DESTINATION /usr/
)

INSTALL(
  PROGRAMS 
  ${CMAKE_CURRENT_SOURCE_DIR}/system/usr/bin/ratflow-session
  ${CMAKE_CURRENT_SOURCE_DIR}/system/usr/bin/rfconfig
  DESTINATION /usr/bin/
)


###### CPACK DEB PACKAGE SETTINGS ######

IF(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
INCLUDE(InstallRequiredSystemLibraries)

SET(CPACK_GENERATOR "DEB")
SET(CPACK_SET_DESTDIR "on")

SET(CPACK_PACKAGE_DESCRIPTION "")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "RATFLOW desktop environment core")
SET(CPACK_PACKAGE_VENDOR "Lukasz Chodyla")
SET(CPACK_PACKAGE_CONTACT ${CPACK_PACKAGE_VENDOR})
SET(CPACK_DEBIAN_PACKAGE_DEPENDS "i3 (>= 4.10), i3blocks (>= 1.4), i3lock, compton, python, suckless-tools, x11-xserver-utils, lxappearance, gnome-themes-extra, feh, xserver-xorg-input-synaptics, terminator, gsimplecal, libnotify-bin, gawk, dunst, gconf2, ulauncher, qt5ct, zenity")
SET(CPACK_DEBIAN_PACKAGE_REPLACES "")
SET(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
SET(CPACK_DEBIAN_PACKAGE_SECTION "ratflow")

SET(CPACK_PACKAGE_VERSION_MAJOR "${VERSION_MAJOR}")
SET(CPACK_PACKAGE_VERSION_MINOR "${VERSION_MINOR}")
SET(CPACK_PACKAGE_VERSION_PATCH "${VERSION_PATCH}-${CMAKE_SYSTEM_NAME}")
#SET(CPACK_DEBIAN_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
SET(CPACK_DEBIAN_ARCHITECTURE ${PACKAGE_SYSTEM_ARCH})

SET(CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${VERSION_MAJOR}.${VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}_${CPACK_DEBIAN_ARCHITECTURE}")
SET(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}")

SET(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_SOURCE_DIR}/deb/preinst;${CMAKE_SOURCE_DIR}/deb/postinst;${CMAKE_SOURCE_DIR}/deb/prerm;${CMAKE_SOURCE_DIR}/deb/postrm;")


INCLUDE(CPack)


ENDIF(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")




