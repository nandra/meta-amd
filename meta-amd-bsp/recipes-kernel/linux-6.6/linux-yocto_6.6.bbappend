require linux-yocto-6.6.inc

PR := "${INC_PR}.0"

SRCREV_machine = "0ccfb8e07e797d57830f3008028de56e22de6e0b"

inherit kernel

do_configure() {
   :; 
}

#S = "${WORKDIR}"



PACKAGES =+ "extra-modules"

EXTRA_OEMAKE += "INSTALL_MOD_STRIP=1"
INSANE_SKIP:${PN} += "already-stripped"

# Conditionally add packages based on machine type
do_siena[prefunc] = "siena_prefunc"
siena_prefunc() {
 # Only add these packages for the 'siena' machine
    if test "${MACHINE}" = "siena"; then
        IMAGE_INSTALL:append = " lscpuinfo git"
    fi
}

DEPENDS += "lib64-setup"
IMAGE_INSTALL:append = " lib64-setup"
VIRTUAL-RUNTIME_init_manager = "systemd"
