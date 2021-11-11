cd icestorm
sed -i 's,Darwin,XXXXX,g' icebox/Makefile
if [ ${ARCH_BASE} == 'windows' ]; then
    ROOTDIR=$(realpath $PKG_CONFIG_PATH/../..)
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/picusb/libftdi1-1.0_devkit_mingw64.zip
    unzip libftdi1-1.0_devkit_mingw64.zip
    cp libftdi1-1.0_devkit_mingw64/lib64/libftdi1.a ${ROOTDIR}/lib
    cp libftdi1-1.0_devkit_mingw64/lib64/libusb-1.0.a ${ROOTDIR}/lib
    cp -r libftdi1-1.0_devkit_mingw64/include/* ${ROOTDIR}/include
    make PREFIX=${INSTALL_PREFIX} DESTDIR=${OUTPUT_DIR} install -j${NPROC} STATIC=1
    sed 's|#!/usr/bin/env python3|#|g' -i  ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/icebox.py
else
    make PREFIX=${INSTALL_PREFIX} DESTDIR=${OUTPUT_DIR} install -j${NPROC} STATIC=1
    mkdir -p ${OUTPUT_DIR}${INSTALL_PREFIX}/libexec
    mv ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/icebox.py ${OUTPUT_DIR}${INSTALL_PREFIX}/libexec/.
    mv ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/iceboxdb.py ${OUTPUT_DIR}${INSTALL_PREFIX}/libexec/.
    for f in $(find ${OUTPUT_DIR}${INSTALL_PREFIX}/bin -type l)
    do
        cp --remove-destination $(readlink -e $f) $f
    done
fi
