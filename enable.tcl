#!/usr/bin/tclsh

set job_files [glob jobs/firefox-aurora-*/config.xml jobs/firefox-nightly-*/config.xml jobs/tests-nightly-*/config.xml jobs/tests-aurora-*/config.xml jobs/expand-aurora-*/config.xml jobs/expand-tests-*/config.xml jobs/trigger-*/config.xml]

foreach file $job_files {
    puts -nonewline "Processing $file..."
    flush stdout
    set fd [open $file]
    set contents [read $fd]
    close $fd

    set newcontents $contents
    if {[regsub -all {<disabled>true</disabled>} $newcontents <disabled>false</disabled> newcontents]} {
        puts -nonewline "enabled..."
    }
    if {![string equal $contents $newcontents]} {
        set fd [open $file w]
        puts -nonewline $fd $newcontents
        puts -nonewline "Replaced..."
        close $fd
    }

    puts "done"
}
