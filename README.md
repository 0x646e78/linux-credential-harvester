# linux-credential-harvester

A script to harvest credentials from Linux systems.

It is also an experiment in using a yaml config file and bash4+ string
manipulation, although I will probably turn the efforts into a POSIX 
compatable script once I get bored with this, as that's not the most 
friendly requirement when on an engagement.

The file `definitions.yml` contains the location of known credential files.

Drop it
-------

Put the `linux-credential-harvester.sh` and `definitions.yml` onto the
system to be audited.  For best results a root account is recommended,
however the script will grab whatever your user has access to. I highly
recommend not trusting me and reading through the bash script before
running it (I pinky swear I didn't try to root your system or troll you).

Run it
------

    ./linux-credential-harvester.sh

Results
------

Any credentials found will be in the `harvested` directory.  It's a little bit
messy in it's organisation of discoveries presently but it'll all be there. 
I hope to end up with a much nicer system of a single file with credentials and
a directory for key files or a single report. Might also look at modular outputs
such as tarballs and exfil.

Contribute
---------

If you want to make it POSIX, or add credentials to the definitions, or you find
a bug, etc please submit an issue or pull request.
